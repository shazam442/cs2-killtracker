class GameStateEventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :game_event

  def game_event
    # implement params.require and params.permit in future
    permitted_params = permit_params()


    steamid = permitted_params&.dig :provider, :steamid
    player = SteamAccount.find_by(steamid: steamid) # can be nil if player not found
    return render_player_not_found(steamid) unless player


    new_match_data = permitted_params&.dig :player, :match_stats # can be nil if in menu

    return render json: { error: "Match data missing", steamid: player&.steamid }, status: :ok if new_match_data.nil?

    previous_match_data = permitted_params&.dig :previously, :player, :match_stats # can be missing in request therefore nil handling below-

    new_match_stat_record = create_match_stat_record(new_match_data, previous_match_data, player, permitted_params)

    return render json: { error: "Match data missing", steamid: player&.steamid }, status: :ok if new_match_stat_record.request_type == "heartbeat_or_other"


    killcount = new_match_data.dig(:kills)
    previous_killcount = previous_match_data&.dig(:kills) || new_match_stat_record.previous_kills

    new_kills = if killcount.nil? || previous_killcount.nil?
      0
    else
      killcount - previous_killcount
    end

    new_kills = new_kills.clamp(0, 1) # prevent too many or negative kills from being added

    player.kills += new_kills

    if player.save
      logger.info "SteamAccount kills updated"
      return render json: { message: "SteamAccount kills updated", kills: player.kills, status: :ok}
    end

    return render json: { message: "Failed to update kills for SteamAccount", status: :ok}
  end

  private

  def create_match_stat_record(new_match_data, previous_match_data, player, permitted_params)
    timestamp = permitted_params&.dig :provider, :timestamp

    new_match_stat_record = MatchStatRecord.new(new_match_data)
    new_match_stat_record.steam_account = player
    new_match_stat_record.timestamp = Time.at(timestamp)
    new_match_stat_record.previous_kills = previous_match_data&.dig(:kills)


    return new_match_stat_record if new_match_stat_record.save
    return false
  end

  def render_player_not_found(player)
    render json: { error: "SteamAccount not found in database", steamid: player&.steamid }, status: :ok
  end

  def permit_params
    params.permit(
      provider: [:timestamp, :steamid, :name, :version, :appid],
      player: [
        :true,
        {
          match_stats: [:kills, :assists, :deaths, :mvps, :score]
        }
      ],
      previously: {
        provider: [:timestamp, :steamid, :name, :version, :appid],
        match_stats: [:kills, :assists, :deaths, :mvps, :score],
        player: [
          :true,
          {
            match_stats: [:kills, :assists, :deaths, :mvps, :score]
          }
        ],
      },
      game_state_event: {
        provider: [:timestamp, :steamid, :name, :version, :appid],
        player: {
          match_stats: [:kills, :assists, :deaths, :mvps, :score]
        },
        previously: {
          provider: [:timestamp, :steamid, :name, :version, :appid],
          match_stats: [:kills, :assists, :deaths, :mvps, :score],
          player: [
            :true,
            {
              match_stats: [:kills, :assists, :deaths, :mvps, :score]
            }
          ],
        }
      },
    )
  end
end

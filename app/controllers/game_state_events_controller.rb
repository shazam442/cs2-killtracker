class GameStateEventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :game_event

  def home
  end

  def game_event
    # implement params.require and params.permit in future
    permitted_params = permit_params()


    steamid = permitted_params&.dig :provider, :steamid
    player = SteamUser.find_by(steamid: steamid) # can be nil if player not found
    return render_player_not_found(steamid) unless player


    new_match_data = permitted_params&.dig :player, :match_stats # can be nil if in menu
    timestamp = permitted_params&.dig :provider, :timestamp

    return render json: { error: "Match data missing", steamid: player&.steamid }, status: :ok if new_match_data.nil?

    previous_match_data = permitted_params&.dig :previously, :player, :match_stats # can be missing in request therefore nil handling below-

    new_match_stat_record = MatchStatRecord.new(new_match_data)
    new_match_stat_record.steam_user = player
    new_match_stat_record.timestamp = Time.at(timestamp)
    new_match_stat_record.previous_kills = previous_match_data&.dig(:kills)
    new_match_stat_record.save

    return render json: { error: "Match data missing", steamid: player&.steamid }, status: :ok if new_match_stat_record.request_type == "heartbeat_or_other"


    killcount = new_match_data.dig(:kills)
    previous_killcount = previous_match_data&.dig(:kills) || new_match_stat_record.previous_kills

    if previous_killcount.nil? then new_kills = 0 # represents case where previous data was omitted by client and therefore cant be subtracted fromd current killcount (could result in new_kills 50 or any big number)

    elsif killcount.nil? then new_kills = 0 # represents error
    else
      new_kills = killcount - previous_killcount
    end

    new_kills = [1, new_kills].min # upper bound of 1 (prevent more than one kill at a time to be registered)
    new_kills = [0, new_kills].max # lower bound of 0 (prevent negative)

    player.kills += new_kills

    if player.save
      logger.info "SteamUser kills updated"
      GameEventsChannel.transmit_kills(player)
      return render json: { message: "SteamUser kills updated", kills: player.kills, status: :ok}
    end

    return render json: { message: "Failed to update kills for SteamUser", status: :ok}
  end

  def hello
    logger.info "button clicked..."
    ActionCable.server.broadcast 'GameEventsChannel', {name: "joffrey"}
  end

  private

  def create_match_stat_record
  end

  def render_player_not_found(player)
    render json: { error: "SteamUser not found in database", steamid: player&.steamid }, status: :ok
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

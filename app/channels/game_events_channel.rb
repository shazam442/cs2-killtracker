# app/channels/game_events_channel.rb
class GameEventsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'GameEventsChannel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.transmit_kills(player)
    ActionCable.server.broadcast(
      'GameEventsChannel',
      { sender: "KilltrackerSchams",
        event: "player_action",
        action: "kill",
        user_data: {
          new_killcount: player.kills,
          steamid: player.steamid
        }}
    )
  end

  def receive(data)

  end
end

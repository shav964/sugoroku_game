# app/channels/game_channel.rb
class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:game_id]}"
  end

  def roll_dice(data)
    # サイコロの結果を全プレイヤーに送信
    ActionCable.server.broadcast "game_#{data['game_id']}", {
      dice_result: rand(1..6),
      current_player: data['player_id']
    }
  end
end

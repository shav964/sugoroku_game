class PlayersController < ApplicationController
  def index
    @players = Player.all
    @player = Player.new  # プレイヤー追加フォーム用の新しいインスタンス
  end

  def create
    logger.debug "Params: #{params.inspect}" # デバッグ用のログ出力
    colors = ["red", "blue", "green", "yellow"]
    player_count = Player.count

    color = colors[player_count % colors.length]

    # 新しいプレイヤーを作成し、position のデフォルト値を 1 に設定
    @player = Player.new(player_params.merge(color: color, position: 1))

    if @player.save
      redirect_to players_path, notice: 'プレイヤーが追加されました！'
    else
      @players = Player.all
      render :index, status: :unprocessable_entity # エラーがある場合は `index` ビューを再表示
    end
  end
  def roll_dice
    @player = Player.find(params[:id])
    dice_roll = rand(1..6)
    new_position = [@player.position + dice_roll, 20].min
    @player.update(position: new_position)
  
    # サイコロ結果とプレイヤーの新しい位置をブロードキャスト
    ActionCable.server.broadcast 'game_channel', {
      player_id: @player.id,
      dice_result: dice_roll,
      new_position: new_position,
      player_name: @player.name
    }
  
    redirect_to players_path, notice: "#{@player.name}が#{dice_roll}進みました！"
  end
  def destroy_all
    Player.delete_all # すべてのプレイヤーをデータベースから削除する
    redirect_to players_path, notice: '全プレイヤーが削除されました！'
  end

  def reset_positions
    Player.update_all(position: 0) # すべてのプレイヤーの位置を0にリセット
    redirect_to players_path, notice: '全プレイヤーの位置がリセットされました！'
  end
  private

  def player_params
    params.require(:player).permit(:name)
  end
end

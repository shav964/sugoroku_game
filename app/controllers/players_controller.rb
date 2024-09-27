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
    dice_roll = rand(1..6) # サイコロを振る（1から6のランダムな数字）
  
    # プレイヤーの位置を更新
    new_position = [@player.position + dice_roll, 20].min
    @player.update(position: new_position)
  
    # ゴールに到達したか確認
    if new_position == 20
      redirect_to players_path, notice: "#{@player.name}がゴールしました！"
    else
      redirect_to players_path, notice: "#{@player.name}が#{dice_roll}進みました！"
    end
  end
  
  private

  def player_params
    params.require(:player).permit(:name)
  end
end

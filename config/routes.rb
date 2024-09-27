Rails.application.routes.draw do
  resources :players do
    member do
      post 'roll_dice'
    end
    collection do
      delete 'destroy_all' # 全プレイヤー削除のルート
      post 'reset_positions' # プレイヤー位置をリセットのルート
    end
  end
  root 'players#index'
end

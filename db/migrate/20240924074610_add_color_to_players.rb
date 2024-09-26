class AddColorToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :color, :string
  end
end

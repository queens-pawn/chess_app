class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.integer :game_id
      t.string :name
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :winner_id

      t.timestamps
    end
  end
end

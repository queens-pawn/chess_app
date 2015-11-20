class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :type
      t.string :color
      t.integer :game_id

      t.timestamps
    end
  end
end

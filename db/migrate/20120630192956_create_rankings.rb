class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :score
      t.integer :player_id
      t.integer :match_id

      t.timestamps
    end
  end
end

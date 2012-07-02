class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :match_id
      t.integer :player_id
      t.integer :score
      t.string :result
      t.string :active
      t.integer :points

      t.timestamps
    end
  end
end

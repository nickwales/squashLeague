class CreatePlayerdivs < ActiveRecord::Migration
  def change
    create_table :playerdivs do |t|
      t.integer :division_id
      t.integer :player_id

      t.timestamps
    end
  end
end

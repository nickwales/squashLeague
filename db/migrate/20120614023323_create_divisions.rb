class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer :season_id
      t.integer :number
      t.string :name

      t.timestamps
    end
  end
end

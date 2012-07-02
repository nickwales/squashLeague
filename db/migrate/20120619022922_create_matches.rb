class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :playerdiv_id
      t.string :index

      t.timestamps
    end
  end
end

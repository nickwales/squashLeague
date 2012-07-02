class AddNameToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :name, :string
    add_column :players, :phone, :string
    add_column :players, :twitter, :string
  end
end

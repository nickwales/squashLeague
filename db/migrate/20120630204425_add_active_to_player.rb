class AddActiveToPlayer < ActiveRecord::Migration
  def change
add_column :players, :active, :boolean
  end
end

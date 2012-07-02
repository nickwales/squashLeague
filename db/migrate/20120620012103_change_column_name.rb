class ChangeColumnName < ActiveRecord::Migration
  def up
	rename_column :playerdivs, :player_id, :player_id
  end

  def down
	rename_column :playerdivs, :player_id, :player_id
  end
end

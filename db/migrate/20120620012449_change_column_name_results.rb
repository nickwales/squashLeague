class ChangeColumnNameResults < ActiveRecord::Migration
  def up
        rename_column :results, :player_id, :player_id
  end

  def down
        rename_column :results, :player_id, :player_id
  end
end

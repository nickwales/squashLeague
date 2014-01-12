class ChangePlayerdivToDivisionInMatches < ActiveRecord::Migration
  def up
    rename_column :matches, :playerdiv_id, :division_id
  end

  def down
  end
end

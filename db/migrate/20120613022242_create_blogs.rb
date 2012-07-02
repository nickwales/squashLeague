class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :summary
      t.string :contents
      t.integer :author

      t.timestamps
    end
  end
end

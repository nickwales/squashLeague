class BlogPostColumnsToLongerLength < ActiveRecord::Migration
  def change
           change_table :blogs do |t|
                   t.change :contents, :text, :limit => 30000
                         t.change :summary, :text, :limit => 1000
                             end
  end
end

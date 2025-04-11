class RenameBlogsToVlogs < ActiveRecord::Migration[7.2]
  def change
    rename_table :blogs, :posts
  end
end

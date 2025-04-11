class AddNoOfLikesToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :no_of_likes, :integer, default: 0
  end
end

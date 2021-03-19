class ChangePostsToPostComments < ActiveRecord::Migration[5.2]
  def change
    rename_table :posts, :post_comments
  end
end

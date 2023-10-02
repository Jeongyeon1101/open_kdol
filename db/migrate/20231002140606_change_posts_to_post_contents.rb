class ChangePostsToPostContents < ActiveRecord::Migration[6.1]
  def change
    rename_table :posts, :post_contents
  end
end

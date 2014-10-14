class AddFriendIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :friend_id, :integer
    add_index :posts, :user_id
    add_index :posts, :friend_id
  end
end

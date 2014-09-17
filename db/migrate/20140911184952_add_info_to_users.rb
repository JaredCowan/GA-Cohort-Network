class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_name, :string
    add_column :users, :user_id, :integer

    add_column :users, :email, :string
    add_column :users, :password_digest, :string

    add_index :users, :email,     :unique => true
    add_index :users, :user_name, :unique => true
  end

end

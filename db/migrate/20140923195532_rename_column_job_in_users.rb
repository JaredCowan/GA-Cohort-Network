class RenameColumnJobInUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_name, :string
    remove_column :users, :job
  end
end

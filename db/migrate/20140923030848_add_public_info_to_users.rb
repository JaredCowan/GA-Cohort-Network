class AddPublicInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string, :default => ""
    add_column :users, :cell_phone, :string, :default => ""
    add_column :users, :public_email, :string, :default => ""
    add_column :users, :birthday, :string, :default => ""
    add_column :users, :github, :string, :default => ""
    add_column :users, :linkedin, :string, :default => ""
    add_column :users, :facebook, :string, :default => ""
    add_column :users, :website, :string, :default => ""
    add_column :users, :city, :string, :default => ""
    add_column :users, :state, :string, :default => ""
    add_column :users, :job, :string, :default => ""
    add_column :users, :job_position, :string, :default => ""
    add_column :users, :job_start, :date, :default => Date.new
    add_column :users, :job_end, :date, :default => Date.new
    add_column :users, :job_description, :string, :default => ""
    add_column :users, :group, :string, :null => false, :default => "student"
    add_column :users, :admin, :boolean, :null => false, :default => false
  end
end

class AddFieldsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :company, :string 
    add_column :jobs, :contact_person, :string 
    add_column :jobs, :contact_email, :string 
    add_column :jobs, :contact_number, :string 
    add_column :jobs, :website, :string 
    add_column :jobs, :start_date, :date 
    add_column :jobs, :url, :string 
    add_column :jobs, :position, :string 
    add_column :jobs, :salery, :string 
    add_column :jobs, :type, :string 
    add_column :jobs, :desription, :text 
    add_column :jobs, :responsibilities, :text 
    add_column :jobs, :qualifications, :text 
    add_column :jobs, :address, :string 
    add_column :jobs, :city, :string 
    add_column :jobs, :state, :string 
    add_column :jobs, :zip, :integer
    add_column :jobs, :user_id, :integer
    add_index  :jobs, :user_id
    
  end
end

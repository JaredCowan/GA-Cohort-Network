class AddDatesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_start, :date
    add_column :users, :job_end, :date
  end
end
class RemoveDatesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :job_start
    remove_column :users, :job_end
  end
end

class RenameColumnTypeInJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :job_type, :string
    remove_column :jobs, :type
  end
end

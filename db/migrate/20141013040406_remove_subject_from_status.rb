class RemoveSubjectFromStatus < ActiveRecord::Migration
  def change
    remove_column :statuses, :subject
  end
end

class AddSubjectToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :subject, :string
    add_index :statuses, :subject
  end
end

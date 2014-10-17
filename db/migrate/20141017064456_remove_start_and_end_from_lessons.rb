class RemoveStartAndEndFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :start
    remove_column :lessons, :end
  end
end

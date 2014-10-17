class AddStartAndEndToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :start, :datetime
    add_column :lessons, :end, :datetime
  end
end

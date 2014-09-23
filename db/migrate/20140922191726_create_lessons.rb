class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :classroom
      t.string :instructor
      t.string :assistant
      t.string :subject
      t.string :title
      t.text :description
      t.boolean :all_day, :default => false
      t.integer :user_id
      t.datetime :start, :null => false, :default => Time.now
      t.datetime :end, :null => false, :default => Time.now
      t.references :user, index: true
      
      t.timestamps
    end
  end
end

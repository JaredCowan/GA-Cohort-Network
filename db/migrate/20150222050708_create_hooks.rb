class CreateHooks < ActiveRecord::Migration
  def change
    create_table :hooks do |t|

      t.timestamps
    end
  end
end

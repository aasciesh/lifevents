class Eventjoin < ActiveRecord::Migration
  def up
  	create_table :eventjoins do |t|
      
      t.integer :eventjoiner_id
      t.integer :joinedevent_id

      t.timestamps
    end
  end

  def down
  end
end

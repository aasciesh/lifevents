class AddIndexesToColumnsThatNeeds < ActiveRecord::Migration
  def change
  	add_index :taglists, :event_id
  	add_index :taglists, :tag_id
  	add_index :eventjoins, :eventjoiner_id
  	add_index :eventjoins, :joinedevent_id
  	add_index :events, :user_id
  end
end

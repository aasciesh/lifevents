class AddEventIdcolumnToTagsList < ActiveRecord::Migration
  def change
  	remove_column :taglists, :user_id
  	add_column :taglists, :event_id, :integer
  end
end

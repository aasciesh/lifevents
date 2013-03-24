class AddClolumnsToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :user_id, :integer
  	add_column :comments, :event_id, :integer
  	add_index :comments, :user_id
  	add_index :comments, :event_id
  end
end

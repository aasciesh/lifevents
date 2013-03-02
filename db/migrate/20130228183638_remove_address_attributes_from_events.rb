class RemoveAddressAttributesFromEvents < ActiveRecord::Migration
  def up
  	remove_column :events, :street
  	remove_column :events, :postcode
  	remove_column :events, :city
  	remove_column :events, :state
  	remove_column :events, :country
    add_column :events, :address, :string
  end

  def down
  end
end

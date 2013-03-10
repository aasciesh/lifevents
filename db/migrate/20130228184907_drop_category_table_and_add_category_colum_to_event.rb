class DropCategoryTableAndAddCategoryColumToEvent < ActiveRecord::Migration
  def up
  	remove_table :categories
  	add_column :events, :category, :string
  end

  def down
  end
end

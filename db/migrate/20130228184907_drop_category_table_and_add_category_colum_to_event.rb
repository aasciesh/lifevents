class DropCategoryTableAndAddCategoryColumToEvent < ActiveRecord::Migration
  def up
  
  	add_column :events, :category, :string
  end

  def down
  end
end

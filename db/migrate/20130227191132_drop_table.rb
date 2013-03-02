class DropTable < ActiveRecord::Migration
  def up
  	drop_table :locations
  end

  def down
  end
end

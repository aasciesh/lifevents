class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :friender_id
      t.integer :friended_id

      t.timestamps
    end
  end
end

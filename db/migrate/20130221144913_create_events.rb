class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :urgency
      t.datetime :post_date
      t.datetime :from_time
      t.datetime :to_time
      t.integer :priority_point

      t.timestamps
    end
  end
end

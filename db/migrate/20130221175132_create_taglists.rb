class CreateTaglists < ActiveRecord::Migration
  def change
    create_table :taglists do |t|
      t.integer :user_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

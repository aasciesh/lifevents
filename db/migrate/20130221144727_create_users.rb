class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :ip
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end

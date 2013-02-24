class AddRememberCookieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_cookie, :string
    add_index   :users, :remember_cookie  
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :unique => true, :null => false
      t.string :email, :unique => true, :null => false
      t.string :password_digest, :null => false
      t.string :session_token, :null => false

      t.timestamps
    end

    add_index :users, :username
    add_index :users, :email
    add_index :users, :session_token
  end
end

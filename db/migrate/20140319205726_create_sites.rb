class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.references :user, :null => false
      t.string :title, :null => false
      t.string :description, :null => false
      t.string :location, :null => false
      t.string :price, :null => false
      t.string :size, :null => false

      t.timestamps
    end

    add_index :sites, :user_id
    add_index :sites, :price
    add_index :sites, :size
    add_index :sites, :location
  end
end

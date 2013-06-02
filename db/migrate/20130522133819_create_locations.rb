class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :address1
      t.string :city
      t.string :state
      t.string :zip, max: 10
      t.string :country
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps, default: false      
      t.integer :order

      t.timestamps
    end
  end
end

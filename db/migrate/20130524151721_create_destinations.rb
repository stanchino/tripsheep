class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.integer :position
      t.integer :trip_id
      t.integer :location_id
      t.datetime :departure_date
      t.datetime :arrival_date, default: nil

      t.timestamps
    end
    add_index :destinations, [:trip_id, :location_id]
    add_index :destinations, :departure_date
    add_index :destinations, :arrival_date
  end
end

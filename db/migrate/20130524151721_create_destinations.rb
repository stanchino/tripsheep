class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.integer :position
      t.integer :trip_id
      t.integer :location_id
      t.integer :days, default: nil
      t.integer :hours, default: nil
      t.datetime :departure
      t.datetime :arrival, default: nil

      t.timestamps
    end
    add_index :destinations, [:trip_id, :location_id]
    add_index :destinations, :departure
    add_index :destinations, :arrival
  end
end

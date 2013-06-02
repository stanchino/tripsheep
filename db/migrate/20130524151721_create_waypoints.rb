class CreateWaypoints < ActiveRecord::Migration
  def change
    create_table :waypoints do |t|
      t.integer :trip_id
      t.integer :location_id
      t.datetime :arrival_date
      t.datetime :departure_date
      t.string :type

      t.timestamps
    end
    add_index :waypoints, [:trip_id, :location_id]
    add_index :waypoints, :arrival_date
    add_index :waypoints, :departure_date
    add_index :waypoints, :type
  end
end

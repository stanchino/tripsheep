class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.datetime :start
      t.datetime :finish
      t.integer :user_id

      t.timestamps
    end
  end
end

class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string :name
      t.datetime :start_date
      t.datetime :end_date, default: nil
      t.string :status

      t.timestamps
    end
  end
end

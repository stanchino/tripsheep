class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end

class CreateTripDates < ActiveRecord::Migration
  def change
    create_table :trip_dates do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :trip, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

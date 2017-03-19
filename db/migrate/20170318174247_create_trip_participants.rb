class CreateTripParticipants < ActiveRecord::Migration
  def change
    create_table :trip_participants do |t|
      t.references :trip, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

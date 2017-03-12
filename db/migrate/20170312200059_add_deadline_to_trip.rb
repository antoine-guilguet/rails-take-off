class AddDeadlineToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :deadline, :datetime
    add_column :trips, :destination, :string
    add_column :trips, :created, :boolean
  end
end

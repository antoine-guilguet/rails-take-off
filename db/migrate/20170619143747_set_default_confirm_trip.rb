class SetDefaultConfirmTrip < ActiveRecord::Migration
  def up
    change_column :trips, :created, :boolean, default: false
  end

  def down
    change_column :trips, :created, :boolean, default: nil
  end
end

class AddStateToCities < ActiveRecord::Migration
  def change
    add_column :cities, :state, :string
    add_column :cities, :country, :string
  end
end

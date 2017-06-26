class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :description
      t.string :status
      t.float :expense
      t.datetime :deadline
      t.datetime :start_date
      t.datetime :end_date
      t.references :trip, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

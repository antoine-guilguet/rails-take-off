class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.datetime :deadline
      t.references :trip, index: true, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end

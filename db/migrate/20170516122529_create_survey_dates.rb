class CreateSurveyDates < ActiveRecord::Migration
  def change
    create_table :survey_dates do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :survey, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

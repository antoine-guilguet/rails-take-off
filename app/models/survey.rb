class Survey < ActiveRecord::Base
  belongs_to :trip
  has_many :survey_dates, dependent: :destroy
end

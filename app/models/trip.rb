class Trip < ActiveRecord::Base

  validates :name, presence: true
  # validates :start_date, presence: true
  # validates :end_date, presence: true

  has_many :trip_dates, dependent: :destroy
  has_many :trip_participants, dependent: :destroy
  has_many :users, through: :trip_participants
end

class Trip < ActiveRecord::Base

  validates :name, presence: true
  validates :destination, presence: true

  has_many :trip_participants, dependent: :destroy
  has_many :users, through: :trip_participants
  belongs_to :host, class_name: 'User', foreign_key: 'user_id'
  has_many :invites, dependent: :destroy
  has_one :survey, dependent: :destroy

  geocoded_by :destination
  after_validation :geocode, if: :destination_changed?
end

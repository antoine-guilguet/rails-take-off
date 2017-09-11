class Trip < ActiveRecord::Base

  #### VALIDATIONS ###
  validates :name, presence: true
  validates :destination, presence: true

  #### RELATIONS ###
  has_many :trip_participants, dependent: :destroy
  has_many :users, through: :trip_participants, dependent: :destroy
  belongs_to :host, class_name: 'User', foreign_key: 'user_id'
  has_many :invites, dependent: :destroy
  has_one :survey, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :expenses, dependent: :destroy

  geocoded_by :destination
  after_validation :geocode, if: :destination_changed?

  def get_trip_invites
    self.invites.where(confirmed: false)
  end

  def get_pending_invites_email
    invites = self.get_trip_invites.map(&:email)
    if invites.length > 1
      result = ""
      invites.each do |invitee|
        result << " #{invitee}"
      end
      return result
    else
      invites.first
    end
  end

  def get_host_full_name
    if self.host.first_name
      self.host.first_name + " " + self.host.last_name
    else
      self.host.email
    end
  end

  def compute_total_expenses
    topics = self.topics.where(status: "Closed")
    sum = 0
    topics.each do |topic|
      sum += topic.expense
    end
    return sum
  end

end

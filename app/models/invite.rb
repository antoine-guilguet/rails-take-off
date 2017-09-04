class Invite < ActiveRecord::Base
  belongs_to :trip

  validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ }, unless: :auto_invitation?
  validates :trip_id, numericality: true, uniqueness: { scope: :email }
  validates :host_id, numericality: true, presence: true
  validates :token, presence: true

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.trip_id, Time.now, rand].join)
  end

  def auto_invitation?
    self.email == User.find(self.host_id).email
  end

  def full_name_of_host
    if self.trip.host.first_name
      self.trip.host.first_name + " " + self.trip.host.last_name
    else
      self.trip.host.email
    end
  end
end

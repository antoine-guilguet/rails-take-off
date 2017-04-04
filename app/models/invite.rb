class Invite < ActiveRecord::Base
  belongs_to :trip

  # validates :email, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ }
  validates :trip_id, numericality: true
  # validates :host_id, numericality: true
  # validates :token, presence: true
  validates :recipient_id, uniqueness: { scope: :trip_id }

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.trip_id, Time.now, rand].join)
  end

end

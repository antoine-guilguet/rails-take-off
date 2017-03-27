class Invite < ActiveRecord::Base
  belongs_to :trip

  validates :email, presence: true
  validates :trip_id, presence: true
  validates :host_id, presence: true

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.trip_id, Time.now, rand].join)
  end

end

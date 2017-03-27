class Invite < ActiveRecord::Base
  belongs_to :trip

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.trip_id, Time.now, rand].join)
  end

end

class TripParticipant < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user

  def render_initials
    !self.user.first_name.nil? ? self.user.first_name.first + self.user.last_name.first : ""
  end
end

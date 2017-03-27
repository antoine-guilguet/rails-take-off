class Invite < ActiveRecord::Base
  belongs_to :trip

  after_create :send_invite_mailer

  private

  def send_invite_mailer
    InviteMailer.join(self).deliver_now
  end
end

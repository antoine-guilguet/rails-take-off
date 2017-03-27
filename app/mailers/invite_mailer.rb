class InviteMailer < ApplicationMailer

  def user_invite(invite, new_user_registration_path)
    @email = invite.email
    @trip= Trip.find(invite.trip_id)
    @host = User.find(invite.host_id)
    @url  = root_url + new_user_registration_path

    mail(to: @email, subject: "Join the Trip")
  end

end

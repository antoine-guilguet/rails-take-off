class InviteMailer < ApplicationMailer

  def join(invite)
    @email = invite.email
    @trip_id = invite.trip_id
    @url  = 'http://localhost:3000/trips/#{@trip_id}'

    mail(to: @email, subject: "Join the Trip")
  end
end

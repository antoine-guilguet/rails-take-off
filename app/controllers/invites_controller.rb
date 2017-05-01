class InvitesController < ApplicationController

  before_action :find_trip, only: [:new, :create, :confirm, :decline]
  before_action :find_invite, only: [:confirm, :decline]

  def new
    @invite = Invite.new
  end

  def create
    @params = params[:invite][:email]
    if @params.count > 1
      # multi-invitation
      @params.each do |invitee|
        @invite = Invite.new(email: invitee)
        build_invitation(@invite)
        send_invitation(@invite)
      end
      redirect_to trips_path
    else
      # single invitation
      @invite = Invite.new(email: params[:invite][:email].first)
      build_invitation(@invite)
      send_invitation(@invite)
      if @invite.valid?
        redirect_to trips_path
      else
        render :new
      end
    end
  end

  def confirm
    confirm_invitation(@invite)
    TripParticipant.create(user_id: current_user.id, trip_id: @invite.trip.id)
    redirect_to trips_path
  end

  def decline
    confirm_invitation(@invite)
    redirect_to trips_path
  end

  private

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

  def find_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.require(:invite).permit(:email)
  end

  def confirm_invitation(invite)
    invite.confirmed = true
    invite.save
  end

  def build_invitation(invite)
    invite.host_id = current_user.id
    invite.trip_id = @trip.id
    invite.generate_token
    invite.recipient_id = User.find_by(email: invite.email).id if User.find_by(email: invite.email)
  end

  def send_invitation(invite)
    if invite.save && invite.recipient_id
      # Send invitation to an existing user
      InviteMailer.user_invite(invite, new_user_session_path(:invite_token => invite.token)).deliver
    elsif invite.save
      # Send invitation to a new user
      InviteMailer.user_invite(invite, new_user_registration_path(:invite_token => invite.token)).deliver
    end
  end
end

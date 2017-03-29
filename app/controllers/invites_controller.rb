class InvitesController < ApplicationController

  before_action :find_trip, only: [:new, :create]

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.host_id = current_user.id
    @invite.trip_id = @trip.id
    @invite.recipient_id = User.find_by(email: @invite.email).id if User.find_by(email: @invite.email)
    @invite.generate_token

    if @invite.save && @invite.recipient_id
      # Send invitation to an existing user
      InviteMailer.user_invite(@invite, new_user_session_path(:invite_token => @invite.token)).deliver
      redirect_to trip_path(@trip)
    elsif @invite.save
      # Send invitation to a new user
      InviteMailer.user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def validate
    @token = params[:invite_token]
    @invite = Invite.find_by_token(@token)
    TripParticipant.create(user_id: @user.id, trip_id: @invite.trip.id) if @user.email == @invite.email
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

end

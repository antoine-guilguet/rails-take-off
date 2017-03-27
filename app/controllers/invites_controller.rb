class InvitesController < ApplicationController
  before_action :find_trip, only: [:new, :create]

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.host_id = current_user.id
    @invite.trip_id = @trip.id
    @invite.generate_token
    if @invite.save
      InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
      redirect_to trip_path(@trip)
    else
      render :new
    end
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

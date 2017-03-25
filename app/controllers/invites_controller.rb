class InvitesController < ApplicationController
  before_action :find_trip, only: [:new, :create]

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.host_id = current_user.id
    @invite.token = SecureRandom.base64(24)
    raise 'good'
    if @invite.save
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

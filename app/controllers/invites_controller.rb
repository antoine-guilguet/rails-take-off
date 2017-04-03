class InvitesController < ApplicationController

  before_action :find_trip, only: [:new, :create, :validate]
  before_action :find_invite, only: [:validate]

  def new
    @invite = Invite.new
  end

  def create
    @params = params[:invite][:email]
    if @params.count > 1
      @params.each do |invitee|
        @invite = Invite.new(email: invitee)
        @invite.host_id = current_user.id
        @invite.trip_id = @trip.id
        @invite.generate_token
        @invite.recipient_id = User.find_by(email: @invite.email).id if User.find_by(email: @invite.email)

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
    else
      @invite = Invite.new(invite_params)
      @invite.host_id = current_user.id
      @invite.trip_id = @trip.id
      @invite.generate_token
      @invite.recipient_id = User.find_by(email: @invite.email).id if User.find_by(email: @invite.email)

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


  end

  def validate
    @response = params[:response]
    @invite.confirmed = true
    @invite.save
    if @response == true && @invite.mail == current_user.email
      TripParticipant.create(user_id: current_user.id, trip_id: @invite.trip.id)
      redirect_to trips_path
    else
      redirect_to trips_path
    end
  end

  def validate_email
    @token = params[:invite_token]
    @invite = Invite.find_by_token(@token)
    TripParticipant.create(user_id: @user.id, trip_id: @invite.trip.id) if @user.email == @invite.email
    TripParticipant.create(trip_id: @invite.trip.id, user_id: current_user.id) if current_user.email == @invite.email
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

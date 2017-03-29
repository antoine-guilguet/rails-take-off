class Users::SessionsController < Devise::SessionsController

  # before_filter :configure_sign_in_params, only: [:create]

  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:invite_token]
    @invite = Invite.find_by_token(@token)
    # TO be removed and create after confirmation with notification
    super
    TripParticipant.create(trip_id: @invite.trip.id, user_id: current_user.id) if current_user.email == @invite.email
  end

  private

  def after_sign_in_path_for(resource)
    trips_path
  end

  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :first_name << :last_name
  # end
end

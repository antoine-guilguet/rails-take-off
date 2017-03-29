class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_sign_up_params
  before_filter :configure_update_params

  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:invite_token]
    @invite = Invite.find_by_token(@token)
    super
    # TO be removed and create after confirmation with notification
    TripParticipant.create(trip_id: @invite.trip.id, user_id: current_user.id) if current_user.email == @invite.email
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name
  end

  def configure_update_params
    devise_parameter_sanitizer.for(:account_update) << :first_name << :last_name
  end

  def after_sign_up_path_for(resource)
    trips_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

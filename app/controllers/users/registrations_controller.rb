class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:invite_token]
    super
    if @token
      @trip = Invite.find_by_token(@token).trip
      TripParticipant.create(user_id: @user.id, trip_id: @trip.id)
    end
  end

  def destroy
    super
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

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :first_name
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

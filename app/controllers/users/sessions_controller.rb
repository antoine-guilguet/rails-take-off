class Users::SessionsController < Devise::SessionsController

  # before_filter :configure_sign_in_params, only: [:create]

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

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :first_name << :last_name
  # end
end

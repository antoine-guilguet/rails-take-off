class Users::SessionsController < Devise::SessionsController

  # before_filter :configure_sign_in_params, only: [:create]

  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:invite_token]
    if @token
      @invite = Invite.find_by_token(@token)
      super
      TripParticipant.create(user_id: current_user.id, trip_id: @invite.trip_id)
      @invite.confirmed = true
      @invite.save
    else
      super
    end
  end

  private

  def after_sign_in_path_for(resource)
    trips_path
  end

  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :first_name << :last_name
  # end
end

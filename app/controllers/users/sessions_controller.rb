class Users::SessionsController < Devise::SessionsController

  # before_filter :configure_sign_in_params, only: [:create]

  def new
    @token = params[:invite_token]
    super
  end

  def create
    @token = params[:invite_token]
    super
  end

  private

  def after_sign_in_path_for(resource)
    @token = params[:invite_token]
      if resource.is_a?(User) && @token
        redirect_to validate_path(:invite_token => @token)
      else
        stored_location_for(resource)
      end
  end

  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :first_name << :last_name
  # end
end

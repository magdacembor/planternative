class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :permit_params, if: :devise_controller?

  def permit_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nickname, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nickname, :avatar])
  end
end

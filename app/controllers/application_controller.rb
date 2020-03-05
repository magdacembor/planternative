class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :permit_params, if: :devise_controller?
  before_action :set_shopping_list, if: :user_signed_in?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def permit_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nickname, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nickname, :avatar])
  end

  def set_shopping_list
    @shopping_list = current_user.shopping_lists.find_by(mark_as_done: false) || ShoppingList.new
  end
end

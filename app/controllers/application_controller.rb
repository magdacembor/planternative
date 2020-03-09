class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :permit_params, if: :devise_controller?
  before_action :set_shopping_list, if: :user_signed_in?
  before_action :user_location

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

  def user_location
    # if json = JSON.parse(RestClient.get("http://ip-api.com/json"))
      # Need a guard clause for in line 21 in case the API does not respond
      # @user_location = Geocoder.search(json["query"]).first.coordinates || [ 51.5198, -0.0940 ]
      # Line 25 TO BE TESTED IN PRODUCTION, remote_ip does not work in dev
      @user_location = Geocoder.search(request.remote_ip).first.coordinates
      if @user_location.empty?
        @user_location = [ 51.5198, -0.0940 ]
      end
    # else
      # Default user location in case the API fails
      # @user_location = [ 51.5198, -0.0940 ]
    # end
  end
end

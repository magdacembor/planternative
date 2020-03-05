class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :find_user, only: :myprofile

  def myprofile
    @shopping_lists = current_user.shopping_lists
    @reviews = current_user.reviews
    @products = current_user.products
  end

  def home; end

  private

  def find_user
    User.find_by(nickname: params[:nickname])
  end
end

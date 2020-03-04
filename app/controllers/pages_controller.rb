class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def myprofile
    @shopping_lists = current_user.shopping_lists
    @reviews = current_user.reviews
    @products = current_user.products
  end

  def home; end
end

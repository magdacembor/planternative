class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def myprofile
  end

  def home; end
end

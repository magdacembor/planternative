class ShoppingListsController < ApplicationController
  before_action :find_list, only: [ :show, :update, :destroy ]

  def show
    @quantity = Quantity.new
  end

  def create
    @shopping_list = ShoppingList.new
    @shopping_list.date = Date.today
    @shopping_list.user = current_user
    if @shopping_list.save
      redirect_to shopping_list_path(@shopping_list)
    else
      redirect_to home_path
    end
  end

  def update
    @shopping_list
  end

  def destroy
  end

  private

  def find_list
    @shopping_list = ShoppingList.find(params[:id])
  end
end

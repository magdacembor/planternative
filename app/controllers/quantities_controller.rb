class QuantitiesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @quantity = Quantity.new(quantity_params)
    @quantity.product = @product
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    # if @shopping_list.present?
    #   @quantity.shopping_list = @shopping_list
    # else
    #   @shopping_list = ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    #   @quantity.shopping_list = @shopping_list
    # end
    @quantity.shopping_list = @shopping_list
    if @quantity.save
      redirect_to product_path(@product)
    else
      render "products/show"
    end
  end

  private

  def quantity_params
    params.require(:quantity).permit(:quantity)
  end
end

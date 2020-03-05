class QuantitiesController < ApplicationController
before_action :find_quantity, only: [ :update, :destroy ]

  def create
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    @product = Product.find(params[:product_id])
    if @shopping_list.products.include?(@product)
      @quantity = @shopping_list.quantities.find_by(product: @product)
      @quantity.increment!(:quantity, params.dig(:quantity, :quantity).to_i)
    else
      @quantity = Quantity.new(quantity_params)
      @quantity.product = @product
      @quantity.shopping_list = @shopping_list
    end
    if @quantity.save
      redirect_to product_path(@product)
    else
      render "products/show"
    end
  end

  def update
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    @quantity.update(quantity_params)
    if @quantity.save
      redirect_to shopping_list_path(@shopping_list)
    else
      render "shopping_lists/show"
    end
  end

  def destroy
    @quantity.destroy
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    redirect_to shopping_list_path(@shopping_list)
  end

  private

  def find_quantity
    @quantity = Quantity.find(params[:id])
  end

  def quantity_params
    params.require(:quantity).permit(:quantity)
  end
end

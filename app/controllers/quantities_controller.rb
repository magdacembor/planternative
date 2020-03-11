class QuantitiesController < ApplicationController
before_action :find_quantity, only: [ :update, :destroy ]

  def create
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    @product = Product.find(params[:product_id])
    if @shopping_list.products.include?(@product)
      @quantity = @shopping_list.quantities.find_by(product: @product)
      if params.dig(:quantity, :quantity).to_i > 0
        @quantity.increment!(:quantity, params.dig(:quantity, :quantity).to_i)
      end
    else
      @quantity = Quantity.new(quantity_params)
      @quantity.product = @product
      @quantity.shopping_list = @shopping_list
    end
    if @quantity.save
      redirect_to product_path(@product), notice: "#{@product.name} added to your list"
    else
      redirect_to product_path(@product), alert: "Quantity must be more than 0"
    end
  end

  def update
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    @quantity.update(quantity_params)
    if @quantity.save
      redirect_to shopping_list_path(@shopping_list), notice: "Quantity updated"
    else
      @review = Review.new
      redirect_to shopping_list_path(@shopping_list)
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

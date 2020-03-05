class QuantitiesController < ApplicationController
  def create
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    @product = Product.find(params[:product_id])
    if @shopping_list.products.include?(@product)
      @quantity = @shopping_list.quantities.find_by(product: @product)
      @quantity.increment!(:quantity)
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
    @quantity = Quantity.find(params[:id])
    @shopping_list = ShoppingList.find_by(mark_as_done: false, user: current_user) || ShoppingList.create(user: current_user, date: Date.today, mark_as_done: false)
    @quantity.update(quantity_params)
    if @quantity.save
      redirect_to shopping_list_path(@shopping_list)
    else
      render 'pages/home'
    end
  end

  def destroy
  end

  private

  def quantity_params
    params.require(:quantity).permit(:quantity)
  end
end

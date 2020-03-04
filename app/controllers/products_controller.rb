class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :find_product,only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit; end

  def update
    @product.update(product_params)
    if @product_save
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to :index
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :ingredients, :price_range, :low_cal, :high_protein, :gluten_free, :calories_per_100g, :carbs_per_100g, :protein_per_100g, :fat_per_100g, photos: [])
  end
end

class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :autocomplete, :api ]
  before_action :find_product, only: [ :show, :edit, :update, :destroy ]

  def autocomplete
    @substitutions = Substitution.global_search(params[:query])
    @results = []
    @substitutions.each do |sub|
        @results << sub.product.name if sub.product.name.match(/#{params[:query]}/i)
        @results << sub.meal.name if sub.meal.name.match(/#{params[:query]}/i)
    end
    @results = @results.uniq
    render json: @results
  end

  def api
    @substitutions = Substitution.global_search(params[:query])
    @results = @substitutions.map do |sub|
        {
          product: sub.product,
          meal: sub.meal,
          recipes: sub.product.recipes
        }
    end
    @results = @results.uniq
    render json: @results
  end

  def index
    if params[:query].present?
      @substitutions = Substitution.global_search(params[:query])
      @products = @substitutions.map { |sub| sub.product }
      @products = @products.uniq
    else
      @products = Product.all
    end
    if params[:low_cal] == "true"
       @products = @products.select { |product| product.low_cal }
    end
    if params[:high_protein] == "true"
      @products = @products.select { |product| product.high_protein }
    end
    if params[:gluten_free] == "true"
      @products = @products.select { |product| product.gluten_free }
    end
  end

  def show
    @stores = @product.stores.geocoded
    @markers = @stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { store: store })
      }
    end
    @review = Review.new
  end

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
    params.require(:product).permit(:name, :description, :ingredients, :price_range, :low_cal, :high_protein, :gluten_free, :calories_per_100g, :carbs_per_100g, :protein_per_100g, :fat_per_100g, images: [])
  end
end

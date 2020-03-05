class ReviewsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new
    @review.update(review_params)
    @review.user = current_user
    @review.product = @product
    if @review.save
      @review = Review.new
    end
    @stores = @product.stores.geocoded
    @markers = @stores.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        infoWindow: render_to_string(partial: "products/info_window", locals: { store: store })
      }
    end
    render "products/show"
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    render "products/show"
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end

class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new

  def new
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new
    @review.update(review_params)
    @review.user = current_user
    if @review.save
      redirect_to product_path(@product)
    else
      render "products/show"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.delete
    render "products/show"
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end

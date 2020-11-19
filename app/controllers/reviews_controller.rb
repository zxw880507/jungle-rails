# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    @product = Product.find params[:product_id]
    @review = @product.review.new(review_params)
    @review.user = current_user
    @review.save!
    redirect_to @product
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy!
    redirect_to @product
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end
end

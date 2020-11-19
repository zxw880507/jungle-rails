class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @user = current_user
    @reviews = @product.review.all
    @review = @product.review.new
  end

end

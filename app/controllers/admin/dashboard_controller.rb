class Admin::DashboardController < ApplicationController
  def show
    @count_products = Product.all.size
    @count_categories = Category.all.size
  end
end

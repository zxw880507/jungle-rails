class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'],
                               password: ENV['ADMIN_PASSWORD']
  def show
    @count_products = Product.all.size
    @count_categories = Category.all.size
  end
  
end

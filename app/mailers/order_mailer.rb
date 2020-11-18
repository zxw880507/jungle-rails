# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
  def order_email(user, order)
    @user = user
    @order = order
    @products = Product.joins('
      JOIN line_items ON line_items.product_id = products.id')
                       .where('line_items.order_id = ?', @order.id)
                       .select('
                        products.*,
                        line_items.quantity as order_quantity
                        ')
    mail(to: @user.email, subject: "Your Jungle order ##{@order.id} is confirmed")
  end
end

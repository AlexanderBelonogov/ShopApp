class OrderConfirmation < ApplicationMailer
  default from: 'abelonogov23@gmail.com'

  def order_confirmation(order)
    @order = order
    @body = JSON.parse(@order.body)
    subject = "Order confirmation ##{@order.id}"
    mail(to: @order.email, subject: subject)
  end
end

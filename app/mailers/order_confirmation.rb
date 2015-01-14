class OrderConfirmation < ApplicationMailer
  default from: 'abelonogov23@gmail.com'

  def order_confirmation(order)
    @order = order
    @crypted_order = crypt.encrypt_and_sign(@order.id)
    @body = JSON.parse(@order.body)
    subject = "Order confirmation ##{@order.id}"
    mail(to: @order.email, subject: subject)
  end
end

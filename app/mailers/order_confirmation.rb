class OrderConfirmation < ApplicationMailer
  default from: 'abelonogov23@gmail.com'

  # Many delay_job methods didn't work correctly,
  # it's the best way to delay mails deliver without creating new class

  def order_confirmation(order)
    @order = order
    subject = "Order confirmation ##{@order.id}"
    mail(to: @order.email, subject: subject)
  end
end

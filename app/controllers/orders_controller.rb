class OrdersController < ApplicationController

  include ApplicationHelper

  before_action :load_categories, :load_last_viewed, :get_cart_products

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.body = @cart.group_by{ |i| i }.map{ |k,v| [k, v.count] }.to_json
      @order.total = fetch_cart_details.last
      @order.save
      OrderConfirmation.delay.order_confirmation(@order)
      cookies.delete(:cart)
      redirect_to root_path
    else
      render :new
    end
  end

  def confirm
    order_id = crypt.decrypt_and_verify(params[:order])
    @message = if order_id
      @order = Order.find(order_id)
      unless @order.confirmed
        @order.update_attributes(confirmed: true)
        "Your order ##{@order.id} successfully confirmed"
      else
        "Your order ##{@order.id} already confirmed"
      end
    else
      'Invalid request!'
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email)
  end
end

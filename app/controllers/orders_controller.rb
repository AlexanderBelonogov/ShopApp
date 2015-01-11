class OrdersController < ApplicationController

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
      cookies.delete(:cart)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email)
  end
end

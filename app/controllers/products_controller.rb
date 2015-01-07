class ProductsController < ApplicationController
  def index
    @products = Product.first
  end
  
  def add_to_cart
    product = Product.find(params[:id])
    if product.present?
      cart = []
      if cookies[:cart].present?
        cart = JSON.parse(cookies[:cart])
      end
      cart.push({id: product.id, description: product.description, price: product.price})
      cookies[:cart] = { value: cart.to_json, expires: 7.days.from_now }
    end
    redirect_to :back
  end
end

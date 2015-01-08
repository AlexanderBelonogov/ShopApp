class ProductsController < ApplicationController

  before_action :get_cart_products, only: [:add_to_cart, :remove_product_from_cart]

  def index
    @products = Product.first
    @categories = Category.all
  end

  def add_to_cart
    product = Product.find(params[:id])
    if product.present?
      @cart.push({id: product.id, description: product.description, price: product.price})
      cookies[:cart] = { value: @cart.to_json, expires: 30.days.from_now }
    end
    redirect_to :back
  end

  def clear_cart
    cookies.delete(:cart)
  end

  def remove_product_from_cart
    @cart.delete_if{ |k| k['id'] == params[:id]}
  end

  protected

  def get_cart_products
    @cart = if cookies[:cart].present?
      cart = JSON.parse(cookies[:cart])
    else
      []
    end
  end
end

class ProductsController < ApplicationController

  before_action :get_cart_products, only: [:add_to_cart, :remove_product_from_cart, :show_cart, :remove_from_cart]
  before_action :find_product, only: [:add_to_cart, :show]
  after_action :add_last_viewed, only: :show
  before_action :load_categories, :load_last_viewed

  def index
    @products = Product.all
  end

  def show
  end

  def show_all
    @products = Product.all
    respond_to { |format| format.js }
  end

  def show_cart
    @cart_items = @cart.group_by{ |i| i }.map{ |k,v| [k, v.count] }
  end

  def add_to_cart
    if @product.present?
      @cart.push({id: @product.id, name: @product.name, price: @product.price})
      cookies[:cart] = { value: @cart.to_json, expires: 30.days.from_now }
    end
    respond_to { |format| format.js }
  end

  def clear_cart
    cookies.delete(:cart)
  end

  def remove_from_cart
    @cart.delete_if{ |k| k['id'].to_s == params[:id]}
    if @cart.empty?
      clear_cart
    else
      cookies[:cart] = { value: @cart.to_json, expires: 30.days.from_now }
    end
    render 'add_to_cart', remove: true, format: :js
  end

  protected

  def find_product
    @product = Product.find(params[:id])
  end

  def add_last_viewed
    product_id = @product.id
    vieved_ids = if cookies[:viewed].present?
      vieved = cookies[:viewed].split(',')
      vieved << product_id.to_s
      vieved.uniq.last(3).join(',')
    else
      product_id
    end
    cookies[:viewed] = { value: vieved_ids, expires: 1.year.from_now }
  end

  def get_cart_products
    @cart = if cookies[:cart].present?
      JSON.parse(cookies[:cart])
    else
      []
    end
  end
end

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

  def create
    @product = Product.new(product_params)
    @product.categories << Category.find(params[:product][:category_ids])
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def show_all
    @products = Product.page(params[:page])
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
    cart = if params[:count].present?
      decrease_items = @cart.select{ |i| i['id'].to_s == params[:id] }
      real_items = decrease_items.take(decrease_items.size - 1)
      @cart - decrease_items + real_items
    else
      @cart.delete_if{ |k| k['id'].to_s == params[:id] }
    end
    if cart.empty?
      clear_cart
    else
      cookies[:cart] = { value: cart.to_json, expires: 30.days.from_now }
    end
    render 'add_to_cart', remove: true, format: :js
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :image, :price)
  end

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
end

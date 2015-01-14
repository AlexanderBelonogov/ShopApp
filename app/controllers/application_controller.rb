class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :fetch_cart_details, :crypt

  def load_categories
    @categories = Category.sorted
  end

  def load_last_viewed
    @last_viewed ||= if cookies[:viewed].present?
      cookies[:viewed].split(',').reverse.map do |id|
        Product.find(id)
      end
    else
      []
    end
  end

  def fetch_cart_details
    if cookies[:cart].present? 
      card_data = JSON.parse(cookies[:cart])
      [JSON.parse(cookies[:cart]).size, JSON.parse(cookies[:cart]).map{|i| i['price']}.inject(:+)]
    else
      [0,0]
    end
  end

  def crypt
    @crypt ||= ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
  end

  def get_cart_products
    @cart = if cookies[:cart].present?
      JSON.parse(cookies[:cart])
    else
      []
    end
  end
end

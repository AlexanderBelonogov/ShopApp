class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end

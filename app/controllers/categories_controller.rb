class CategoriesController < ApplicationController

  before_action :get_category, :load_categories, :load_last_viewed

  def show
    @products = @category.products
  end

  def change_position
    case params[:move]
    when 'up'
      @category.increment_position
    when 'down'
      @category.decrement_position
    end
    redirect_to :back
  end

  def get_category
    @category = Category.find(params[:id])
  end
end

class Product < ActiveRecord::Base
  paginates_per 9
  has_many :product_categories
  has_many :categories, through: :product_categories
end

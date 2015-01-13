class Product < ActiveRecord::Base
  paginates_per 9
  has_many :product_categories
  has_many :categories, through: :product_categories
  validates_presence_of :name, :price

  mount_uploader :image, ProductImageUploader

  scope :search_by_name, ->(name) { where('lower(name) like lower(?)', "%#{name}%") }
end

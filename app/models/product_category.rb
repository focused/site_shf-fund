class ProductCategory < ActiveRecord::Base
  include PositionedInCategory

  alias_attribute :parent_id, :product_category_id

  has_many :products
  belongs_to :product_category
  has_many :product_categories

  validates :name, :path, presence: true
  validates :path, length: { maximum: 500 }, uniqueness: [:product_category]

  class << self
    def main_with_secondary
      main.includes(:product_categories)
    end

    def main
      in_category(nil)
    end
  end

  def subcategory_ids
    product_categories.ids
  end

  def get_product(id)
    products.find_by(path_id: id)
  end

end

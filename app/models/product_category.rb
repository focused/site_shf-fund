class ProductCategory < ActiveRecord::Base
  include PositionedInCategory

  belongs_to :product_category
  has_many :product_categories
  has_many :products

  validates :name, :path, presence: true
  validates :path, length: { maximum: 500 }

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

  alias_attribute :parent_id, :product_category_id
end

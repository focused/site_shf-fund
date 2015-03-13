class ProductCategory < ActiveRecord::Base
  include PositionedInCategory

  alias_attribute :parent_id, :product_category_id

  belongs_to :product_category
  has_many :product_categories, dependent: :destroy
  has_many :products, dependent: :destroy
  has_and_belongs_to_many :extra_products, -> { ordered },
    class_name: "Product",
    join_table: "extra_categories",
    foreign_key: "extra_category_id"

  scope :secondary, -> { where.not(product_category_id: nil) }
  scope :without,   -> id { where.not(id: id) }

  validates :name, :path, presence: true
  validates :path, length: { maximum: 500 }, uniqueness: [:product_category]

  class << self
    def main_with_secondary
      main.includes(:product_categories).ordered
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

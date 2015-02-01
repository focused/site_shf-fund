class ProductCategory < ActiveRecord::Base
  belongs_to :product_category
  has_many :product_categories
  has_many :products

  scope :ordered, -> { order(:position) }

  validates :name, :path, presence: true
  validates :position, numericality: { only_integer: true }

  def self.main
    where(product_category_id: nil).includes(:product_categories)
  end

  def subcategory_ids
    product_categories.ids
  end

  def get_product(id)
    products.find_by(path_id: id)
  end
end

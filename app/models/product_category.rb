class ProductCategory < ActiveRecord::Base
  include PositionedInCategory

  belongs_to :product_category
  has_many :product_categories
  has_many :products

  validates :name, :path, presence: true
  validates :path, length: { maximum: 500 }

  class << self
    def main
      in_category(nil).includes(:product_categories)
    end
  end

  def subcategory_ids
    product_categories.ids
  end

  def get_product(id)
    products.find_by(path_id: id)
  end

  # private

  # def get_max_position
  #   self.class
  #     .unscoped
  #     .in_category(product_category)
  #     .maximum(:position).to_i + 1
  # end
end

class Product < ActiveRecord::Base
  include PositionedInCategory

  before_validation :fill_defaults

  belongs_to :product_category
  has_many :product_photos, -> { ordered }, dependent: :destroy
  has_and_belongs_to_many :product_couples,
    class_name: "Product",
    join_table: "product_couples",
    association_foreign_key: "couple_id"

  scope :all_products, -> category do
    where(product_category_id: [category.id, category.subcategory_ids].flatten)
  end

  validates :name, :path_id, presence: true
  validates :path_id, length: { maximum: 500 }
  validates :wear_pct, numericality: { maximum: 99.99 }
  validates :price, numericality: { maximum: 999999.99 }

  def fill_defaults
    self.path_id ||= id
  end
end

class Product < ActiveRecord::Base
  include PositionedInCategory

  alias_attribute :parent_id, :product_category_id

  after_initialize :normalize
  after_create :attach_extra_category
  before_validation :fill_defaults

  belongs_to :product_category
  has_and_belongs_to_many :extra_categories, -> { ordered },
    class_name: "ProductCategory",
    join_table: "extra_categories",
    association_foreign_key: "extra_category_id"
  has_and_belongs_to_many :product_couples, -> { ordered },
    class_name: "Product",
    join_table: "product_couples",
    association_foreign_key: "couple_id"
  has_many :product_photos, -> { ordered }, dependent: :destroy
  has_many :order_items

  scope :all_products, -> category do
    return category.extra_products if category.parent_id

    where(product_category_id: [category.id, category.subcategory_ids].flatten)
  end

  validates :name, :path_id, presence: true
  validates :path_id, length: { maximum: 500 }, uniqueness: [:product_category]
  validates :wear_pct, numericality: { maximum: 99.99 }
  validates :price, numericality: { maximum: 999999.99 }

  private

  def normalize
    self.product_category_id ||= parent_id
  end

  def fill_defaults
    self.path_id ||= id
  end

  def attach_extra_category
    # self.extra_categories << product_category
    product_category.extra_products << self
  end
end

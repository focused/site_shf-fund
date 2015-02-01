class Product < ActiveRecord::Base
  before_validation :fill_defaults

  belongs_to :product_category
  has_many :product_photos, dependent: :destroy
  has_and_belongs_to_many :product_couples,
    class_name: "Product",
    join_table: "product_couples",
    association_foreign_key: "couple_id"
    # foreign_key: "product_id"

  scope :ordered, -> { order(:position) }

  scope :all_products, -> category do
    where(product_category_id: [category.id, category.subcategory_ids])
  end

  validates :name, :path_id, presence: true
  validates :position, numericality: { only_integer: true }

  def fill_defaults
    self.path_id ||= id
  end
end

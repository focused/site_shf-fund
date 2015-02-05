class OrderItem < ActiveRecord::Base
  belongs_to :product

  scope :ordered, -> { order(:created_at) }

  validates :count, numericality: { minimum: 1, maximum: 99 }
  validates :price, numericality: { maximum: 999999.99 }

  alias_attribute :parent_id, :product_id
end

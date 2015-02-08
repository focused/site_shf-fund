class OrderItem < ActiveRecord::Base
  alias_attribute :parent_id, :product_id

  belongs_to :product
  belongs_to :order

  scope :ordered, -> { order(:created_at) }

  validates :count, numericality: { minimum: 1, maximum: 99 }
  validates :price, numericality: { maximum: 999999.99 }

end

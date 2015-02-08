class Order < ActiveRecord::Base
  alias_attribute :parent_id, :created_at

  enum state: [:new_one, :handled]

  has_many :order_items, -> { ordered }, dependent: :destroy

  validates :name, :company_name, :phone, :email, presence: true
end

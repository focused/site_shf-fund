class Order < ActiveRecord::Base
  has_many :order_items, -> { ordered }, dependent: :destroy
end

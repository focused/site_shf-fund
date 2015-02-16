class Order < ActiveRecord::Base
  alias_attribute :parent_id, :state

  mount_uploader :details_file, FileUploader

  enum state: [:new_one, :handled]

  has_many :order_items, -> { ordered }, dependent: :destroy

  validates :name, :phone, :email, presence: true, if: -> x { x.real? }

  def sum
    order_items
      .lazy
      .map { |x| x.price * x.count }
      .reduce(:+)
  end
end

class Setting < ActiveRecord::Base
  include Positioned

  alias_attribute :parent_id, :position

  validates :key, presence: true
  validates :key, :value, length: { maximum: 255 }

  class << self
    def get(key)
      res = where(key: key).first
      res ? res.value : nil
    end
  end
end

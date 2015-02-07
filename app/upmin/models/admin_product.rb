require_relative "concerns/has_product_category"

class AdminProduct < Upmin::Model
  include HasProductCategory

  class << self
    def items_per_page
      30
    end

    def color
      :light_blue
    end
  end

  def primary_photo
    product_photos.first
  end
end


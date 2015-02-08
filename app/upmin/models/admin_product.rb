require_relative "concerns/has_product_category"

class AdminProduct < Upmin::Model
  include HasProductCategory

  attributes :product_category_id, :name, :path_id, :price, :factory, :factory_url,
    :factory_country, :keywords, :description, :fabric, :size, :wear_pct, :code, :warranty,
    :position, :updated_at

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

  def app_url
    [get_parent.path, path_id].join("/")
  end
end


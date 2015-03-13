module Catalog
  module_function

  ProductCard = Struct.new :product, :path do
    include ProductBase

    def self.call(model, *args)
      yield model, new(model, *args)
    end

    def url
      "#{path ? path : product_category_path}/#{product.path_id}"
    end

    def preview_url
      primary_photo && primary_photo.src.main_preview
    end

    def product_category_path
      product.product_category && product.product_category.path
    end
  end
end

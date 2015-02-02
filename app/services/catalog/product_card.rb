module Catalog
  module_function

  ProductCard = Struct.new :product do
    def self.call(model, *args)
      obj = new model, *args
      yield model, obj
    end

    def url
      "#{product_category_path}/#{product.path_id}"
    end

    def preview_url
      primary_photo && primary_photo.src.preview
    end

    private

    def primary_photo
      product.product_photos.first
    end

    def product_category_path
      product.product_category && product.product_category.path
    end
  end
end

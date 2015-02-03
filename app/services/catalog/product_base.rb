module Catalog
  module ProductBase


    private

    def primary_photo
      product.product_photos.first
    end
  end
end

module Catalog
  class ProductDocument < Document
    include ProductBase

    def self.call(request_path, path_id)
      model = ::Document.match(request_path.to_s, name)

      return unless model && document = new(model, request_path, path_id)
      return unless document.category && document.product

      document
    end

    def product
      @product ||= category.extra_products.find_by(path_id: path_id)
    end

    def subcategories
      parent_category.product_categories.ordered
    end

    def main_photo_url
      primary_photo && primary_photo.src.normal
    end

    def photo_previews
      product.product_photos.take(4)
    end

    def related_products
      product.product_couples
    end

    def breadcrumbs
      bcs = {}
      parent_category && bcs = { parent_category.name => parent_category.path }
      bcs.merge(category.name => category.path)
    end

    def breadcrumb_name
      product.name
    end
  end
end

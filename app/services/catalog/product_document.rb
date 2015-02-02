module Catalog
  class ProductDocument < Document
    def self.call(request_path, path_id)
      model = ::Document.match(request_path.to_s, name)
      model && document = new(model, request_path, path_id)
      document.product && document
    end

    def product
      category.products.find_by(path_id: path_id)
    end

    def breadcrumbs
      {}
      # return {} unless parent_category
      # { parent_category.name => parent_category.path }
    end

    def breadcrumb_name
      # product.name
    end
  end
end

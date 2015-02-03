module Catalog
  class ProductCategoryDocument < Document
    def self.call(request_path)
      model = ::Document.match(request_path.to_s, name)

      return unless model && document = new(model, request_path)
      return unless document.category

      document
    end

    def breadcrumbs
      return {} unless parent_category
      { parent_category.name => parent_category.path }
    end

    def breadcrumb_name
      category.name
    end

    def all_products(page = 0, size = 16)
      Product
        .all_products(category)
        .order(:product_category_id)
        .ordered
        .limit(size)
        .offset(page * size)
    end

    def has_more_products?
      all_products(1).any?
    end
  end
end

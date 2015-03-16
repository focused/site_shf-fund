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

    def custom_path
      parent_category && path
    end

    def all_products(page = 0, size = 16)
      Rails.logger.ap "="*80
      Product
        .all_products(category)
        .joins(:product_category)
        .order(
          "product_categories.product_category_id != #{Root.main_category_id}",
          "product_categories.position"
        )
        .ordered
        .limit(size)
        .offset(page * size)
        # .select(
        #   "products.*",
        #   "product_categories.id",
        #   "product_categories.position"
        # )
    end

    def any_products?
      Product.all_products(category).any?
    end

    def has_more_products?
      all_products(1).any?
    end
  end
end

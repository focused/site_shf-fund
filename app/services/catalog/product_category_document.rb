module Catalog
  class ProductCategoryDocument < Document
    class << self
      def parents_join_sql
        <<-Query
        INNER JOIN product_categories AS parents
        ON product_categories.product_category_id = parents.id
        Query
      end

      def category_order_sql
        <<-Query
        (CASE product_categories.product_category_id
          WHEN #{::Root.main_category_id} THEN 0
          ELSE 1
        END)
        Query
      end

      def call(request_path)
        model = ::Document.match(request_path.to_s, name)

        return unless model && document = new(model, request_path)
        return unless document.category

        document
      end
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
      Product
        .all_products(category)
        .joins(:product_category)
        .joins(self.class.parents_join_sql)
        .order(self.class.category_order_sql)
        .order("parents.position")
        .order("product_categories.position")
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

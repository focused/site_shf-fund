module Catalog
  class ProductCategoryDocument < Document
    attr_reader :product_category

    def all_products(page = 0, size = 16)
      @all_products ||=
        Product
          .all_products(@category)
          .ordered
          .limit(size)
          .offset(page * size)
          .to_a
    end

    def view_path
      "catalog/product_categories/show"
    end
  end
end

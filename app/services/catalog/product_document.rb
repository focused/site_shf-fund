module Catalog
  class ProductDocument < Document
    attr_reader :product, :product_category

    def initialize(id, request_path)
      super
      @path_id = id
    end

    def product
      @product ||= @category.get_product(@path_id)
    end
  end
end

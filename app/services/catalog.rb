module Catalog
  module_function

  def create_data(scope_attrs)
    -> attrs, items = [] do
      category = ProductCategory.where(scope_attrs).first_or_create(
        attrs.merge(
          position: (
            ProductCategory.where(
              product_category: scope_attrs[:product_category]
            ).maximum(:position) || -1
          ) + 1
        )
      )
      items.each do |key, value|
        create_data(
          name: value,
          product_category: category
        ).(path: "#{category.path}/#{key}")
      end
    end
  end
end

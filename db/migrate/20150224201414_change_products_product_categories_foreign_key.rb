class ChangeProductsProductCategoriesForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :products, :product_categories
    add_foreign_key :products, :product_categories, on_delete: :cascade
  end
end

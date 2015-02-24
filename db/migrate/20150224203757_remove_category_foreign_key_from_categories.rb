class RemoveCategoryForeignKeyFromCategories < ActiveRecord::Migration
  def change
    remove_foreign_key :product_categories, :product_categories
  end
end

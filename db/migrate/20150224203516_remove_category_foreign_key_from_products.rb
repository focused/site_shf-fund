class RemoveCategoryForeignKeyFromProducts < ActiveRecord::Migration
  def change
    remove_foreign_key :products, :product_categories
  end
end

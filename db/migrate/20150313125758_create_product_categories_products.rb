class CreateProductCategoriesProducts < ActiveRecord::Migration
  def change
    create_table :extra_categories do |t|
      t.integer :product_id, null: false
      t.integer :extra_category_id, null: false
    end
    add_index :extra_categories, [:product_id, :extra_category_id], unique: true

    ProductCategory.all.each do |category|
      category.extra_products << category.products
    end
  end
end

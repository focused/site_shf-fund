class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.references :product_category, index: true
      t.string :name, null: false
      t.string :path, size: 500, default: "/", null: false
      t.integer :position, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_categories, :product_categories
    add_index :product_categories, [:product_category_id, :path], unique: true
  end
end

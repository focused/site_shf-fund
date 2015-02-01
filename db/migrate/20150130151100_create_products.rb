class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :product_category, index: true
      t.integer :position, default: 0, null: false
      t.string :name, null: false
      t.string :path_id, null: false
      t.string :factory, default: "", null: false
      t.string :factory_url, default: "", null: false
      t.string :factory_country, default: "", null: false
      t.string :description, default: "", null: false
      t.string :fabric, default: "", null: false
      t.string :size, default: "", null: false
      t.decimal :wear_pct, precision: 4, scale: 2, default: 0
      t.string :code, default: "", null: false
      t.decimal :price, precision: 8, scale: 2
      t.string :warranty, default: "", null: false

      t.timestamps null: false
    end
    add_foreign_key :products, :product_categories
  end
end

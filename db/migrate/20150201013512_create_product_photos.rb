class CreateProductPhotos < ActiveRecord::Migration
  def change
    create_table :product_photos do |t|
      t.references :product, index: true
      t.string :src
      t.integer :position, default: 0, null: false
    end
    add_foreign_key :product_photos, :products
  end
end

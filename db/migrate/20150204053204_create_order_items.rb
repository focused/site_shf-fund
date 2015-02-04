class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :name
      t.string :code
      t.decimal :price, precision: 8, scale: 2
      t.decimal :sum, precision: 8, scale: 2
      t.references :product, index: true
      t.integer :count, default: 1, null: false

      t.timestamps null: false
    end
    add_foreign_key :order_items, :products
  end
end

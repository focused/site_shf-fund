class ChangeOrderItemsProductsForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :order_items, :products
    add_foreign_key :order_items, :products, on_delete: :nullify
  end
end

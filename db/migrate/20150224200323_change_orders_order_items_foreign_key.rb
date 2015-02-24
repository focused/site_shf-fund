class ChangeOrdersOrderItemsForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :order_items, :orders
    add_foreign_key :order_items, :orders, on_delete: :cascade
  end
end

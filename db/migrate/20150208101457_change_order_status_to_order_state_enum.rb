class ChangeOrderStatusToOrderStateEnum < ActiveRecord::Migration
  def change
    remove_column :orders, :status
    add_column :orders, :state, :integer, default: 0, null: false
  end
end

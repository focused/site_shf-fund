class OrdersController < ApplicationController
  # before_action :set_order_item, only: [:update]

  def show
    @document = OrderDocument.new
  end

  def update
    session["store.current_order_id"] = nil
  end

  private

  # def set_order_item
  #   @order_item = OrderItem.find(params[:id])
  # end

  # def order_item_params
  #   params.require(:order_item).permit(:product_id, :count)
  # end
end

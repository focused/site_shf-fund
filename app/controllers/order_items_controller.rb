class OrderItemsController < ApplicationController
  def index
    @document = OrderDocument.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save
      redirect_to @order_item, notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :count)
  end
end
class OrderItemsController < ApplicationController
  before_action :set_product, only: %w(create update)
  before_action :set_order_item, only: %w(update)

  def create
    if (order_item = client_order.order_items.find_by(product_id: @product.id))
      order_item.update!(count: order_item.count + 1)
    else
      client_order.order_items << new_order_item
    end

    redirect_to cart_path
  end

  def update
    @order_item.count = @order_item.count + 1 if @order_item.persisted?
    @order_item.save!

    redirect_to cart_path
  end

  private

  def set_product
    @product = Product.find(params[:order_item]["product_id"])
  end

  def set_order_item
    @order_item = OrderItem.find_by(id: params[:id]) || new_order_item
  end

  def new_order_item
    OrderItem.new(product_id: @product.id, price: @product.price, name: @product.name)
  end
end

class OrdersController < ApplicationController
  # before_action :set_order_item, only: [:update]

  def show
    @document = OrderDocument.new
  end

  def update
    client_order.real = true
    if client_order.update(order_params)
      session["store.current_order_id"] = nil
      redirect_to cart_path, notice: <<-MSG
        Спасибо, мы заказ приняли.
        В течение ближайшего дня специалист свяжется с Вами и уточнит детали заказа.
        Чтобы ускорить работу – Вы можете связаться по телефону #{Setting.get("contacts.phone")}
      MSG
    else
      @document = OrderDocument.new
      render :show
    end
  end

  private


  def order_params
    params.require(:order).permit(:company_name, :name, :phone, :email, :details_file)
  end
end

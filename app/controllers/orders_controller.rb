class OrdersController < ApplicationController
  # before_action :set_order_item, only: [:update]

  def show
    @document = OrderDocument.new

    respond_to do |format|
      format.html
      format.pdf { render pdf: "show", layout: "pdf.html.slim" }
    end
  end

  def update
    if params[:count]
      params[:count].each do |id, value|
        OrderItem.find(id).update(count: value)
      end
    end

    respond_to do |format|
      format.html do
        client_order.real = true
        if client_order.update(order_params)
          OrderMailer.new_order(client_order).deliver
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
      format.pdf do
        redirect_to order_url(client_order, format: "pdf")
      end
    end
  end

  private


  def order_params
    params.require(:order).permit(:company_name, :name, :phone, :email, :details_file)
  end
end

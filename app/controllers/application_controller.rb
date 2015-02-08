class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def not_found
    render file: "public/404", layout: false
  end

  def client_order
    return @order if @order

    @order =
      if session["store.current_order_id"]
        res = Order.find_by(id: session["store.current_order_id"])
        unless res
          res = Order.create
          session["store.current_order_id"] = res.id
        end
        res
      else
        Order.create
      end

    session["store.current_order_id"] ||= @order.id

    @order
  end
  helper_method :client_order
end

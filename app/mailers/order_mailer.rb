class OrderMailer < ApplicationMailer
  def new_order(order)
    @order = order
    mail(
      to: Setting.get("store.email"),
      subject: "Оформлен новый заказ"
    )
  end
end

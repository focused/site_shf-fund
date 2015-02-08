class OrderMailerPreview < ActionMailer::Preview
  def new_order
    order = Order.find(Order.pluck(:id).sample)

    OrderMailer.new_order(order)
  end
end

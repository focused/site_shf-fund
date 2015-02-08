class OrderDocument
  def initialize
  end

  def items
    # @items ||= OrderItem.ordered
  end

  def breadcrumbs
    {}
  end

  def breadcrumb_name
    I18n.t "order_items.index.title"
  end
end

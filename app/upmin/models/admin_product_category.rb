require_relative "concerns/has_product_category"

class AdminProductCategory < Upmin::Model
  include HasProductCategory

  class << self
    def color
      :dark_red
    end
  end

  def add_child_title
    "Добавить товарную позицию"
  end

  def new_child_path
    upmin_new_model_path(klass: Product, parent_id: id)
  end
end


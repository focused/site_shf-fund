require_relative "concerns/has_product_category"

class AdminProductCategory < Upmin::Model
  include HasProductCategory

  class << self
    def color
      :brown
    end

    def breadcrumbs(current_id)
      new(get(current_id)).breadcrumbs { |x| "?parent_id=#{x[:id]}" }
    end

    def get(current_id)
      ProductCategory.find_by(id: current_id)
    end
  end

  # def parent_id=(id)
  #   self.parent = ProductCategory.find(id)
  # end

  def set_default_path(parent_id)
    parent_id && parent = ProductCategory.find(product_category_id)
    self.path =
      "#{parent ? parent.path : ''}/#{rand(999) * 1000}"
  end

  def add_child_title
    "Добавить товарную позицию"
  end

  def new_child_path
    upmin_new_model_path(klass: Product, parent_id: id)
  end
end


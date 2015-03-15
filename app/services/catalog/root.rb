class Root
  class << self
    def main_category_id
      Setting.get("site.main_product_category").to_i
    end
  end

  def id
    0
  end

  def subcategory_ids
    [main_category.product_categories.ids] #+ ProductCategory.ordered.ids
  end

  def parent_id
  end

  def product_category
  end

  private

  def main_category
    ProductCategory.find_by(id: self.class.main_category_id) ||
    ProductCategory.new
  end
end

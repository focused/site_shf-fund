class Root
  def id
    Setting.get("site.main_product_category").to_i
  end

  def subcategory_ids
    ProductCategory.ordered.ids - [id]
  end

  def parent_id
  end

  def product_category
  end
end

class Root
  def id
    0
  end

  def subcategory_ids
    ProductCategory.ordered.ids
  end

  def parent_id
  end

  def product_category
  end
end

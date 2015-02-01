class Root
  def id
    0
  end

  def subcategory_ids
    ProductCategory.ordered.ids
  end
end

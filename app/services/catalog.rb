module Catalog
  module_function

  def get_document(request_path)
    ProductCategoryDocument.(request_path)
  end

  class << self
    alias_method :any_document?, :get_document
  end
end

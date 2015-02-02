module Catalog
  class Document
    include App::DocumentEntity

    attr_reader :path

    def category
      @category ||= at_root? ? Root.new : ProductCategory.find_by(path: path)
    end
  end
end

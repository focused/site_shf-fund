module Catalog
  class Document
    include App::DocumentEntity

    ROOT_PATH = "/"

    attr_reader :path

    def self.get_category(path)
      path == ROOT_PATH ? Root.new : ProductCategory.find_by(path: path)
    end

    def initialize(path)
      @path = path
      @category = self.class.get_category(@path)
    end
  end
end

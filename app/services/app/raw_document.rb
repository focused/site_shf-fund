module App
  class RawDocument
    include DocumentEntity

    PATH_FORMATTER = -> str { str || "root" }

    attr_reader :path
    alias_method :view_path, :path

    def initialize(request_path)
      @path = PATH_FORMATTER[request_path]
    end

    def handler
      self.class.name
    end
  end
end


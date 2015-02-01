module App
  class RawDocument
    include DocumentEntity

    PATH_FORMATTER = -> str { str || "root" }

    def initialize(request_path)
      @view_path = PATH_FORMATTER[request_path]
    end

    def handler
    end
  end
end


module App
  class StaticDocument
    include DocumentEntity

    def self.call(request_path)
      model = Document.match(request_path.to_s)
      model && new(model)
    end

    def breadcrumbs
    end

    alias_method :at_root?, :at_model_root?
  end
end

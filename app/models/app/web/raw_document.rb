module App::Web
  RawDocument = Struct.new :path_string do
    def self.to_proc
      method(:new).to_proc
    end
    # ActionView::Base.new("app/views/").render(
    #   file: "app/documents/#{path_string}"
    # )

    def path
      path_string || "root"
    end
  end
end

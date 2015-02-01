module App
  module_function

  def get_document(request_path, id)
    [Document, RawDocument].reduce(nil) do |res, model|
      res || model.(request_path)
    end
  end

  def handle(document)
    document.handler && yield(const_get(document.handler).(document.path))
  end

  def create_data(scope_attrs)
    -> attrs do
      Document.where(scope_attrs).first_or_create(
        attrs.merge(position: (Document.maximum(:position) || -1) + 1)
      )
    end
  end
end

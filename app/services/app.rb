module App
  module_function

  ROOT_PATH = "/"
  PATH_FORMATTER = -> str { str.rjust(str.size + 1, "/") }

  # def get_document(request_path)
  #   StaticDocument.(request_path)
    # TODO ?
    # [StaticDocument, RawDocument].reduce(nil) do |res, model|
    #   res || model.(request_path)
    # end
  # end

  # class << self
  #   alias_method :any_document?, :get_document
  # end

  # def handle(document, request_path = document.path)
  #   document.handler && yield(const_get(document.handler).(request_path))
  # end
end

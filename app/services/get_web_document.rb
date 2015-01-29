module GetWebDocument module_function
  def call(request_path)
    [WebDocument, RawDocument].reduce(nil) do |res, model|
      res || model.parse(request_path)
    end
    # Value[request_path] | WebDocument | RawDocument
  end
end


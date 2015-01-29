RawDocument = Struct.new :path do
  include AnyDocument

  PATH_FORMATTER = -> str { str || "root" }

  def self.parse(request_path)
    new PATH_FORMATTER[request_path]
  end
end


class WebDocument < ActiveRecord::Base
  include AnyDocument

  PATH_FORMATTER = -> str { str.rjust(str.size + 1, "/") }

  validates :path, presence: true

  def self.parse(request_path)
    find_by(path: PATH_FORMATTER[request_path.to_s])
  end
end


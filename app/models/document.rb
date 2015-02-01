class Document < ActiveRecord::Base
  include Positioned

  PATH_FORMATTER = -> str { str.rjust(str.size + 1, "/") }

  validates :name, :path, presence: true
  validates :path, length: { maximum: 500 }

  def self.call(request_path)
    ordered.find_by(path: PATH_FORMATTER[request_path.to_s])
  end
end


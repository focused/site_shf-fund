class Document < ActiveRecord::Base
  PATH_FORMATTER = -> str { str.rjust(str.size + 1, "/") }

  validates :name, :path, presence: true

  def self.call(request_path)
    find_by(path: PATH_FORMATTER[request_path.to_s])
  end
end


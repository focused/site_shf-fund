class Document < ActiveRecord::Base
  include Positioned

  alias_attribute :parent_id, :position

  before_validation :normalize

  validates :name, :path, presence: true
  validates :path, length: { maximum: 500 }

  # TODO: move to App
  def self.match(request_path, handler_class_name = nil)
    scope = where(handler: handler_class_name).ordered

    res = scope.find_by(path: App::PATH_FORMATTER[request_path])
    res || (handler_class_name.present? && scope.find_by(path: "/"))
  end

  private

  def normalize
    self.path = App::PATH_FORMATTER[path]
  end

end


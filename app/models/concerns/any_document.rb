module AnyDocument
  extend ActiveSupport::Concern

  # class_methods do
  #   def get(x)
  #     x || parse(x)
  #   end
  #   alias_method :get, :call
  # end

  def match(type)
    yield path if is_a?(type)
  end
end

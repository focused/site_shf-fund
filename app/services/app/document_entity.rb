module App::DocumentEntity
  extend ActiveSupport::Concern

  included do
    class << self
      alias_method :call, :new
    end
  end

  class_methods do
    def [](id)
      method(:new).curry[id]
    end
  end
end

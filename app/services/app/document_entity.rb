module App::DocumentEntity
  extend ActiveSupport::Concern

  included do
    attr_reader :model, :path, :path_id

    delegate :name, :content, to: :model

    class << self
      # alias_method :call, :new
    end
  end

  def initialize(model, request_path = nil, path_id = nil)
    @model = model
    @path = App::PATH_FORMATTER[request_path.to_s]
    @path_id = path_id
  end

  def at_model_root?
    model.path == App::ROOT_PATH
  end

  def at_root?
    path == App::ROOT_PATH
  end

  class_methods do
    # def [](id)
    #   method(:new).curry[id]
    # end
  end
end

module Upmin
  class Association
    def title
      return model.model_class.human_attribute_name(name)
    end
  end
end

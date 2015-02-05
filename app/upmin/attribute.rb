module Upmin
  class Attribute
    def visible_in_results?
      %i(handler content description created_at updated_at).none? { |key| key == name }
    end

    def visible_in_model?
      %i(handler id).none? { |key| key == name }
    end

    def label_name
      return model.class.model_class.human_attribute_name(name)
    end
  end
end

class Upmin::Model
  def self.humanized_name(type = :plural)
    res = model_class.model_name
    type == :plural ? res.human(count: model_class.count) : res.human
  end
end

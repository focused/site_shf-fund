class Upmin::Model
  def self.humanized_name(type = :plural)
    res = model_class.model_name
    type == :plural ? res.human(count: 10) : res.human
  end
end

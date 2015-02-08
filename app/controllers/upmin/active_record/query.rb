module Upmin::ActiveRecord
  module Query

    def results
      res = klass.model_class.ransack(search_options).result(distinct: true)

      res = res.where(real: true) if klass.model_class.attribute_names.include?("real")

      if klass.model_class.attribute_names.include?("position")
        res.order(:parent_id, :position, created_at: :desc)
      else
        res.order(:parent_id, created_at: :desc)
      end
    end

    private


  end
end

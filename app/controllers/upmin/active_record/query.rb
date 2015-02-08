module Upmin::ActiveRecord
  module Query

    def results
      res = klass.model_class.ransack(search_options).result(distinct: true)

      res = res.where(real: true) if klass.model_class.attribute_names.include?("real")

      if klass.model_class.attribute_names.include?("position")
        res.order(:parent_id, :position)
      else
        res.order(:parent_id)
      end

      res = res.order(created_at: :desc) if klass.model_class.attribute_names.include?("created_at")
      res
    end

    private


  end
end

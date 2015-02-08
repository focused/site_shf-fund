module Upmin::ActiveRecord
  module Query

    def results
      res = klass.model_class.ransack(search_options).result(distinct: true)

      if klass.model_class.attribute_names.include?("position")
        res.order(:parent_id, :position)
      else
        res.order(:parent_id)
      end
    end

    private


  end
end

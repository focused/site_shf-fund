module Upmin::ActiveRecord
  module Query

    def results
      return klass.model_class.ransack(search_options).result(distinct: true).order(:parent_id, :position)
    end

    private


  end
end

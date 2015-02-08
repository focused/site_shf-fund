module Upmin::ModelsHelper
  def link_to_new_model
    return if @model.class.respond_to?(:creatable?) && !@model.class.creatable?

    opts = { klass: @model.model_class }
    opts.merge!(parent_id: @model.parent_id) if @model.respond_to?(:parent_id)

    link_to(
      "Создать еще одну запись >>",
      upmin_new_model_path(opts),
      class: "alert-link"
    )
  end
end

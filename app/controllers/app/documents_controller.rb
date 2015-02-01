module App
  class DocumentsController < ApplicationController
    unless Rails.env.development?
      rescue_from ActionView::MissingTemplate, with: :not_found
    end

    def show
      @document = App.get_document(*params.values_at(:path, :path_id))
      App.handle(@document) do |h|
        name = h.class.name.demodulize.underscore
        instance_variable_set "@#{name}", h
        render h.view_path, locals: { name.to_sym => h }
      end
    end
  end
end


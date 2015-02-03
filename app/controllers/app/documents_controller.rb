module App
  class DocumentsController < ApplicationController
    unless Rails.env.development?
      rescue_from ActionView::MissingTemplate, with: :not_found
    end

    def show
      @document = App::StaticDocument.(params[:path])
      # render "root" unless @document
      # TODO: refactor
      # App.handle(@document, "/#{params[:path]}") do |h|
      #   name = h.class.name.demodulize.underscore
      #   instance_variable_set "@#{name}", h
      #   render h.view_path, locals: { name.to_sym => h }
      # end
    end
  end
end


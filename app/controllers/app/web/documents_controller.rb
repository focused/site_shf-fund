module App::Web
  class DocumentsController < ApplicationController
    rescue_from ActionView::MissingTemplate, with: :not_found

    def show
      @document = GetDocument.(params[:path])

      render @document.path
    end

    def not_found
      render file: "public/404"
    end
  end
end

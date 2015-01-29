class WebDocumentsController < ApplicationController
  rescue_from ActionView::MissingTemplate, with: :not_found

  def show
    @document = GetWebDocument.(params[:path])
    @document.match RawDocument, &method(:render)
  end
end


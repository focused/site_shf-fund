class Catalog::ProductCategoriesController < ApplicationController
  def show
    @document = Catalog.get_document(params[:path])
  end
end

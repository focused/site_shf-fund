class Catalog::ProductCategoriesController < ApplicationController
  def show
    @document = Catalog::ProductCategoryDocument.(params[:path])
    session[:last_catalog_path] = request.path
  end
end

class Catalog::ProductsController < ApplicationController
  def show
    @document = Catalog::ProductDocument.(params[:path], params[:path_id])
    session[:last_catalog_path] = request.path
  end
end

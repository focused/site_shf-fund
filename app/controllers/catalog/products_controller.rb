class Catalog::ProductsController < ApplicationController
  def show
    @document = Catalog::ProductDocument.(params[:path], params[:path_id])
  end
end

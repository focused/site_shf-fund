class Catalog::ProductCategoriesController < ApplicationController
  def show
    @document = Catalog::ProductCategoryDocument.(params[:path])
  end
end

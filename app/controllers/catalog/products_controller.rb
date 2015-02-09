class Catalog::ProductsController < ApplicationController
  def index
    return unless params[:search]
    query = params[:search][:query]

    return if query.size < 3

    @products = Product.where(
      "name LIKE :q OR factory LIKE :q OR code LIKE :q OR keywords LIKE :qq",
      q: "#{query}%", qq: "%#{query}%"
    )
  end

  def show
    @document = Catalog::ProductDocument.(params[:path], params[:path_id])
  end
end

require_dependency "upmin/application_controller"

module Upmin
  class ProductsController < ApplicationController
    def update
      @product = Product.find(params[:id])

      @product.product_couples =
        Product.where(id: params[:product][:product_couple_ids].reject(&:blank?))
    end

    private

  end
end


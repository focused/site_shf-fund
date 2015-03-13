require_dependency "upmin/application_controller"

module Upmin
  class ProductsController < ApplicationController
    def update
      @product = Product.find(params[:id])

      if params[:product][:product_couple_ids]
        @product.product_couples =
          Product.where(id: params[:product][:product_couple_ids]
                 .reject(&:blank?))
      end

      if params[:product][:extra_category_ids]
        @product.extra_categories =
          [@product.product_category] +
          ProductCategory.where(id: params[:product][:extra_category_ids]
                         .reject(&:blank?))
      end
    end

    private

  end
end


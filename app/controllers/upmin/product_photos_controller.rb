require_dependency "upmin/application_controller"

module Upmin
  class ProductPhotosController < ApplicationController
    def create
      @product = Product.find(params[:parent_id])

      params[:product_photo][:src].each do |file|
        photo = ProductPhoto.new(product: @product)
        photo.src = file
        photo.save!
      end
    end

    def destroy
      unless params[:product_photo]
        render nothing: true and return
      end

      @product = Product.find(params[:parent_id])
      @product.product_photos
        .where(id: params[:product_photo][:_remove])
        .destroy_all
    end

    private

  end
end


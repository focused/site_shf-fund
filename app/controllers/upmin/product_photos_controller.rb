require_dependency "upmin/application_controller"
require_dependency "./app/helpers/upmin/models_helper"

module Upmin
  class ProductPhotosController < ApplicationController
    def create
      @product_photos = []

      params[:product_photo][:src].each do |file|
        photo = ProductPhoto.new(product_id: params[:parent_id])
        photo.src = file
        photo.save!
        @product_photos << photo
      end
    end

    def destroy
      unless params[:product_photo]
        render nothing: true and return
      end

      ProductPhoto.where(id: params[:product_photo][:_remove]).destroy_all
      @product_photos = Product.find(params[:parent_id]).product_photos
    end

    private

  end
end


# encoding: utf-8

class ProductPhotoUploader < ApplicationUploader
  include CarrierWave::MiniMagick

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  version :normal do
    process resize_to_fit: [324, 485]
  end

  version :preview do
    process resize_to_fit: [76, 107]
  end

  version :thumb do
    process resize_to_fill: [64, 64]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

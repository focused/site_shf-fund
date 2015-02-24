class ChangeProductPhotosProductsForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :product_photos, :products
  end
end

class AddUniqeIndexOnPathIdToProducts < ActiveRecord::Migration
  def change
    add_index :products, [:product_category_id, :path_id], unique: true
  end
end

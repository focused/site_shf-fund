class CreateProductCouples < ActiveRecord::Migration
  def change
    create_join_table :products, :products, table_name: "product_couples" do |t|
      t.integer :product_id
      t.integer :couple_id
    end
    add_index :product_couples, [:product_id, :couple_id], unique: true
  end
end

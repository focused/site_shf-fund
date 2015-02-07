class AddKeywordsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :keywords, :text, default: "", null: false
  end
end

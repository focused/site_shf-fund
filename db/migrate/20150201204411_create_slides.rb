class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :src
      t.text :content, default: "", null: false
      t.integer :position, index: true
    end
  end
end

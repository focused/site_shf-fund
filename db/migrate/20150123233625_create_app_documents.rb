class CreateAppDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :path, size: 500, default: "/", null: false, index: true
      t.text :content, default: "", null: false
      t.integer :position, index: true
      t.string :handler

      t.timestamps null: false
    end

    add_index :documents, [:path, :handler], unique: true
  end
end

class CreateAppWebDocuments < ActiveRecord::Migration
  def change
    create_table :web_documents do |t|
      t.string :name
      t.string :path, size: 500, default: "/", null: false
      t.text :content, default: "", null: false

      t.timestamps null: false
    end

    add_index :web_documents, :path, unique: true
  end
end

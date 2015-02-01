class CreateAppDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :path, size: 500, default: "/", null: false
      t.text :content, default: "", null: false
      t.integer :position, default: 0, null: false
      t.string :handler

      t.timestamps null: false
    end

    add_index :documents, [:path, :handler], unique: true
  end
end

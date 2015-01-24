class CreateAppWebDocuments < ActiveRecord::Migration
  def change
    create_table :app_web_documents do |t|
      t.string :path, size: 500

      t.timestamps null: false
    end
  end
end

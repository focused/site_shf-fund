class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name, null: false, default: ""
      t.string :company_name, null: false, default: ""
      t.string :phone, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :details_file
      t.text :comment, null: false, default: ""
      t.boolean :real, default: false, null: false
      t.string :status, default: "new", null: false

      t.timestamps null: false
    end
  end
end

class AddKindToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :kind, :string, default: "string", null: false
  end
end

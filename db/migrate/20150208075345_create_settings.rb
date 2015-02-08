class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key, null: false
      t.string :value
      t.integer :position, index: true
    end
  end
end

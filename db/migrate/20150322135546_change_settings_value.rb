class ChangeSettingsValue < ActiveRecord::Migration
  def change
    change_column :settings, :value, :text
  end
end

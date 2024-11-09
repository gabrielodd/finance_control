class RenameConfigurationToUserConfiguration < ActiveRecord::Migration[6.0]
  def change
    rename_table :configurations, :user_configurations
  end
end

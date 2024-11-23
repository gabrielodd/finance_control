class AddCategoriesToUserConfigurations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_configurations, :categories, :text
  end
end

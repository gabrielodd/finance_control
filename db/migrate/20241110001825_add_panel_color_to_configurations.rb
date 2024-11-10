class AddPanelColorToConfigurations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_configurations, :panel_color, :string
  end
end

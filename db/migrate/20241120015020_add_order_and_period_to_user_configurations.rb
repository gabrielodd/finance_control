class AddOrderAndPeriodToUserConfigurations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_configurations, :order, :string
    add_column :user_configurations, :period, :string
  end
end

class AddCurrencyToUserConfigurations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_configurations, :currency, :string, default: "$"
  end
end

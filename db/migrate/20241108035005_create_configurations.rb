class CreateConfigurations < ActiveRecord::Migration[6.0]
  def change
    create_table :configurations do |t|
      t.string :locale
      t.references :user, foreign_key: true, unique: true

      t.timestamps
    end
  end
end

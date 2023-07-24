class AddRepeatingToDespesa < ActiveRecord::Migration[6.0]
  def change
    add_column :despesas, :repeating, :boolean
  end
end

class AddDateToDespesa < ActiveRecord::Migration[6.0]
  def change
    add_column :despesas, :date, :date
  end
end

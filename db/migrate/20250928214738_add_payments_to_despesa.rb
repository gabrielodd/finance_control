class AddPaymentsToDespesa < ActiveRecord::Migration[6.0]
  def change
    add_reference :despesas, :payment, foreign_key: true
  end
end

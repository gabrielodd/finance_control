class AddUserToDespesa < ActiveRecord::Migration[6.0]
  def change
    add_reference :despesas, :user, foreign_key: true
  end
end

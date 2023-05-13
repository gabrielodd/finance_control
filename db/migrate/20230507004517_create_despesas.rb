class CreateDespesas < ActiveRecord::Migration[6.0]
  def change
    create_table :despesas do |t|
      t.string :descricao
      t.decimal :valor, precision: 15, scale: 2

      t.timestamps
    end
  end
end

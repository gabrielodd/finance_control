class CreateDespesas < ActiveRecord::Migration[6.0]
  def change
    create_table :despesas do |t|
      t.integer :categoria
      t.string :descricao
      t.decimal :valor

      t.timestamps
    end
  end
end

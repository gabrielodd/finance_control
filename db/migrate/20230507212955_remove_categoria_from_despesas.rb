class RemoveCategoriaFromDespesas < ActiveRecord::Migration[6.0]
  def change
    remove_column :despesas, :categoria, :string
    remove_column :despesas, :categoria_id_id, :bigint
  end
end

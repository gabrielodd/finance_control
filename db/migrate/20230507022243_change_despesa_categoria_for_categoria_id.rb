class ChangeDespesaCategoriaForCategoriaId < ActiveRecord::Migration[6.0]
  def change
    add_reference :despesas, :categoria, foreign_key: true
  end
end

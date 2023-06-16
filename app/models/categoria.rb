class Categoria < ApplicationRecord
  has_many :despesas

  def categoria_name
    name
  end
end

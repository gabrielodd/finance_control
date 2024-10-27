class Categoria < ApplicationRecord
  has_many :despesas
  belongs_to :user, optional: true

  def categoria_name
    name
  end
end

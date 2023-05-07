class Despesa < ApplicationRecord
  belongs_to :categoria

  def mes
    created_at.strftime("%B")
  end
end

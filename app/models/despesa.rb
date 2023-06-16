class Despesa < ApplicationRecord
  belongs_to :categoria
  belongs_to :user

  delegate :name, to: :categoria

  scope :within_month_from_user, -> (user_id, date) {
    where(user_id: user_id, date: date.beginning_of_month..date.end_of_month)
  }

  scope :total_spendings_current_month_from_user, -> (user_id, date) {
    where(user_id: user_id, date: date.beginning_of_month..date.end_of_month).sum(:valor)
  }

  scope :within_month_from_user, -> (user_id, date) {
    where(user_id: user_id, date: date.beginning_of_month..date.end_of_month)
  }
  def categoria_name
    categoria.name
  end

  def mes
    date.strftime("%B")
  end
end

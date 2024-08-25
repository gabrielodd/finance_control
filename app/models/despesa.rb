class Despesa < ApplicationRecord
  before_validation :set_default_valor

  belongs_to :categoria
  belongs_to :user

  delegate :name, to: :categoria

  validates :user, :date, presence: true

  scope :per_user, -> (user_id) {
    where(user_id: user_id)
  }

  scope :within_month_from_user, -> (user_id, date) {
    where(user_id: user_id, date: date.beginning_of_month..date.end_of_month)
  }

  scope :total_spendings_current_month_from_user, -> (user_id, date) {
    where(user_id: user_id, date: date.beginning_of_month..date.end_of_month).sum(:valor)
  }

  scope :within_month_from_user, -> (user_id, date) {
    where(user_id: user_id, date: date.beginning_of_month..date.end_of_month)
  }

  def mes
    date.strftime("%B")
  end

  def mes_ano
    date.strftime("%B %Y")
  end

  def ano
    date.strftime("%Y")
  end

  def self.create_every_month(despesa_id, user_id)
    despesa = Despesa.find(despesa_id)
    # new_despesa = despesa.dup
    # new_despesa.date = despesa.date + 1.month
    # new_despesa.save
    # Despesa.delay(run_at: 1.month.from_now).create_every_month(new_despesa.id, new_despesa.user_id)
    
    Despesa.delay(run_at: 1.month.from_now).create_every_month(despesa.id, despesa.user_id)
  end

  private

  def set_default_valor
    self.valor ||= 0
  end
end
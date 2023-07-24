class Despesa < ApplicationRecord
  belongs_to :categoria
  belongs_to :user

  delegate :name, to: :categoria

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

  def self.create_every_month(despesa_id)
    despesa = Despesa.find(despesa_id)
    new_despesa = despesa.dup

    # Adjust the date attribute to be 1 month from the original
    new_despesa.date = despesa.date + 1.month

    # Save the new model
    new_despesa.save
  end
end

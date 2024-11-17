class Categoria < ApplicationRecord
  has_many :despesas
  belongs_to :user, optional: true

  scope :user_categories, ->(user) { where(user_id: [nil, user.id]).order(user_id: :asc) }
end

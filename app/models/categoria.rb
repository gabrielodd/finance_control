class Categoria < ApplicationRecord
  has_many :despesas
  belongs_to :user, optional: true

  scope :user_categories, ->(user) { where(user_id: [nil, user.id]).order(user_id: :asc) }

  scope :global_categories, -> { where(user_id: nil) }
end

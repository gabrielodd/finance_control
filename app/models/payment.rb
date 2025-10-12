class Payment < ApplicationRecord
  has_many :despesas
  belongs_to :user
end
class User < ApplicationRecord
  has_one :user_configuration, dependent: :destroy
  has_many :despesas
  has_many :categorias
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

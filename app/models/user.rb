# represents a user
class User < ApplicationRecord
  has_secure_password

  has_many :costs, dependent: :destroy

  validates_presence_of :name, :lastname, :email, :password_digest
  validates_numericality_of :saldo
end

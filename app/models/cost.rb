# represents a cost attributed to a user
class Cost < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :description, :code, :amount
  validates_numericality_of :amount
end

class User < ApplicationRecord
  # Validations
  validates :email, presence: true
  validates :email, uniqueness: true

  # Releational
  has_many :questionnaires, dependent: :destroy
end

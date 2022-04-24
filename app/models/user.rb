class User < ApplicationRecord
  has_many :questionnaire, dependent: destroy
end

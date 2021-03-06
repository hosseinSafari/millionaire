class Question < ApplicationRecord
  has_many :questionnaire_questions
  has_many :questions, through: :questionnaire_questions
  has_many :options, dependent: :destroy
end

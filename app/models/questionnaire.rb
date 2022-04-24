class Questionnaire < ApplicationRecord
  has_many :questionnaire_questions

  belongs_to :user
end

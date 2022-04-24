class Option < ApplicationRecord
  has_many :answers

  belongs_to :question
end

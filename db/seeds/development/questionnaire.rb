user = ::User.create!(email: "test_user@millionaire.com")

10.times do |i|
    question = ::Question.create!(point: 5.0, context: "Question #{i}")
    4.times do |j|
        option = ::Option.create!(question: question, context: "Option #{j}")
        option.update(is_correct: true) if j == 1
    end
end

questionnaire = ::Questionnaire.create!(user: user)

question_ids = ::Question.pluck(:id)
selected_ids = question_ids&.sample(ENV.fetch("ASSIGN_QUESTION_COUNT", "5").to_i)

selected_ids&.each do |id|
    question = ::Question.find(id)
    QuestionnaireQuestion.create!(question: question, questionnaire: questionnaire)
end
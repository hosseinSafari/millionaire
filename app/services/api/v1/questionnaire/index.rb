module Api
    module V1
        module Questionnaire
            class Index
                include Peafowl

                attribute :current_user, ::User

                validates :current_user, presence: true

                def call
                    find_or_create_questionnaire
                    context[:questionnaire] = @questionnaire
                end

                private

                def find_or_create_questionnaire
                    @questionnaire = @current_user.questionnaires&.where(is_completed: false)&.last
                    unless @questionnaire.present?
                        @questionnaire = @current_user.questionnaires.create!(point: "0")
                        assign_questions
                    end
                end

                def assign_questions
                    question_ids = ::Question.pluck(:id)
                    selected_ids = question_ids&.sample(ENV.fetch("ASSIGN_QUESTION_COUNT", "5").to_i)
                
                    selected_ids&.each do |id|
                        question = ::Question.find(id)
                        QuestionnaireQuestion.create!(question_id: question.id, questionnaire_id: @questionnaire.id)
                    end
                end
            end
        end
    end
end
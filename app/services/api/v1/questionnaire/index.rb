module Api
    module V1
        module Questionnaire
            class Index
                include Peafowl

                attribute :current_user, ::User
                attribute :option_id, ::String
                attribute :email, ::String

                validates :current_user, presence: true

                def call
                    find_or_create_questionnaire
                    return if @questionnaire&.user&.email != @email

                    if @option_id.present?
                        @option = find_option
                        @answer = create_answer
                        calculate_point
                        context[:correct_option] = find_correct_option
                    end

                    context[:is_completed] = check_complete_questionnaire
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

                def calculate_point
                    questionnaire_point = @questionnaire.point
                    @questionnaire&.update!(point: questionnaire_point + @option&.point)
                    @questionnaire&.questionnaire_questions&.where(question_id: @option&.question&.id)&.last&.update!(is_used: true)
                end

                def find_option
                    ::Option.find(@option_id)
                end

                def create_answer
                    ::Answer.create!(questionnaire_id: @questionnaire.id, option_id: @option.id)
                end

                def check_complete_questionnaire
                    completed_answer_count = @questionnaire&.questionnaire_questions&.where(is_used: true).count
                    question_count = @questionnaire&.questions&.count

                    result = completed_answer_count == question_count
                    @questionnaire&.update!(is_completed: true) if result.present?

                    result
                end

                def find_correct_option
                    @option&.question&.options&.where(is_correct: true)&.last
                end
            end
        end
    end
end
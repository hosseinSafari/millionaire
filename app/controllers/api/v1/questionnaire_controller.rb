module Api
    module V1
        class QuestionnaireController < ApplicationController
            before_action :authenticate_me

            def index
                result = ::Api::V1::Questionnaire::Index.call(current_user: @current_user)
                return render json: { errors: result.errors }, status: 400 if result.errors.present?

                @question = result[:questionnaire]&.questionnaire_questions&.where(is_used: false)&.first&.question
            end
        end
    end
end

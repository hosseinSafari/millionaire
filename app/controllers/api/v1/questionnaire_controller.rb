module Api
    module V1
        class QuestionnaireController < ApplicationController
            before_action :authenticate_me

            def index
                result = ::Api::V1::Questionnaire::Index.call(parmeters)
                @error = result.errors
                render :file => 'public/404.html', :status => :not_found, :layout => false if result.errors.present?

                @question = result[:questionnaire]&.questionnaire_questions&.where(is_used: false)&.first&.question
                @score = result[:questionnaire]&.point
                @is_completed = result[:is_completed]
                @correct_option = result[:correct_option].present? ? result[:correct_option] : nil
            end

            private

            def parmeters
                params.permit(:option_id, :email)&.merge(current_user: @current_user)
            end
        end
    end
end

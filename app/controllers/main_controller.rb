class MainController < ApplicationController
    def index
        @result = []
        ::Questionnaire.all.each do |questionnaire|
            answers = questionnaire.answers.joins(:option)&.where("options.is_correct IS ?", true)
            option_ids = answers&.pluck(:option_id)
            questions_ids = ::Option.where(id: option_ids)&.pluck(:question_id)
            total_point = ::Question.where(id: questions_ids).sum(&:point)
            @result.append({questionnaire: questionnaire, total_point: total_point})

        end
        @result.sort_by! {|res| -res[:total_point]}
    end
end

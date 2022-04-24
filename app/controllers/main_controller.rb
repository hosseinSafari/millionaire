class MainController < ApplicationController
    def index
        @questionnaires = ::Questionnaire.joins(:user)&.where.not(point: 0)&.order(:point)&.uniq
    end
end

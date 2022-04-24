class ApplicationController < ActionController::Base

    protected

    def authenticate_me
        @current_user = ::User.find_by(email: params[:email]&.downcase&.strip)
        @current_user ||= ::User.create!(email: params[:email]&.downcase&.strip)
    end
end

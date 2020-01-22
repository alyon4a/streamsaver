class ApplicationController < ActionController::Base

    def current_user 
        if session[:user_id]
            User.find(session[:user_id])
        end 
    end 

    def logged_in?
        redirect_to login_path unless current_user 
    end 

end


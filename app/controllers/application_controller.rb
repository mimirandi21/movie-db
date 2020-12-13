class ApplicationController < ActionController::Base

    helpers do

        def logged_in?
            !!session[:user_id]
        end

        def current_user
            @current_user = User.find_by(id: session[:user_id])
        end
    end
    
end

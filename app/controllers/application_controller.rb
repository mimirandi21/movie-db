class ApplicationController < ActionController::API
    helper_method :logged_in?, :current_user

    # def verify_authenticity_token
    #     request.headers['X-CSRF-Token'] ||= request.headers['X-XSRF-TOKEN']
    #     super
    # end

    private

        def logged_in?
            !!session[:user_id]
        end

        def current_user
            @current_user = User.find_by(id: session[:user_id])
        end
    

end

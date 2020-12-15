class UsersController < ApplicationController 
    # skip_before_action :verify_authenticity_token, :only => [:index, :show]

    def home
        @message = session[:message]
        session[:message] = nil
    end

    def new
        if logged_in? #verifys user logged in (using helpers)
            #error message
            @message = "You are already logged in"
            redirect_to user_path(current_user)
        else
            @user = User.new
            render new_user_path
        end
    end

    def create
        @user = User.new(user_params)
        if !@user.save
            session[:message] = "Oops, let's try that again!"
            redirect_to root_path
        else
            @user.save
            session[:user_id] = @user.id
            session[:message] = "Please log in."
            redirect_to users_signin_path
        end
    end

    def omniauth
        #get access tokens from google using google oauth2
        @user = User.from_omniauth(auth)        
            if @user.save
                redirect_to user_path(@user)
            else
                redirect_to root_path
            end
    end

    def signin
        if logged_in?

        render 'users/signin'
    end

    def login
        @user = User.find_by(email: params[:email])
        return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end 

    def logout
        session.delete :user_id
        redirect_to '/'
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
    end

    def show
        @user = current_user
    end

    def index
    end

    def destroy
        session.delete :user_id
    end


    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :uid)
    end

    def auth
        request.env['omniauth.auth']
    end
end

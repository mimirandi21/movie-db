class UsersController < ApplicationController

    def home
        @message = session[:message]
        session[:message] = nil
    end

    def new
        if logged_in? #verifys user logged in (using helpers)
            #error message
            @message = "You are already logged in"
        else
            #create session message (@message), route to home
            @message = session[:message]
            session[:message] = nil
            erb :'/sessions/home'
        end
    end

    def create
        @user = User.new(user_params)
        if !@user.save
            session[:message] = "Oops, let's try that again!"
            redirect_to '/users/new'
        else
            @user.save
            session[:user_id] = @user.id
            session[:message] = "Please log in."
            redirect_to users_login_path
        end
    end

    def omniauth
        #get access tokens from google using google oauth2
        @user = User.from_omniauth(auth)        
            if @user.save
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                session[:message] = "Login failed, try again."
                redirect_to root_path
            end
    end

    def login
        @user = User.new
    end 

    def edit
    end

    def update
    end

    def show
        @user = current_user
    end

    def index
    end

    def destroy
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :uid)
    end

    def auth
        request.env['omniauth.auth']
    end
end

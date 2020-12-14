class UserMoviesController < ApplicationController
    before_action :set_user_movies, except: [:new, :create]
    before_action :set_user

    def new
        @user_movies = UserMovie.new
    end

    def create
        @user_movie = UserMovie.create(user_movie_params)
        if @user_movie.valid?
            session[:message] = "Your collection has been updated."
            
        else
            session[:message] = "Update failed.  Please try again."
        end
        redirect_to user_movie_movies_path(@user_movie)
    end

    def edit
    end

    def update
        @user_movie.update(user_movie_params)

    end

    def destroy
    end

    def set_collection
        @user_movie = UserMovie.find(params[:id])
        puts @user_movie
    end

    def set_user
        @user = User.find(session[:user_id])
        if @user 
            puts @user
        else
            session[:message] = "You need to log in to complete this action."
            redirect_to root_path
        end
    end

    private

    def user_movie_params
        params.require(:user_movie).permit(:source, :user_rating, :user_notes, :private_notes, :user_id, :movie_id)
    end

end
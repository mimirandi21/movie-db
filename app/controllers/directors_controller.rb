class DirectorsController < ApplicationController
    before_action :set_director, only: [:show]

    def new
        @director = Director.new
    end

    def create
        @director = Director.create(director_params)
    end

    def show
    end

    def index
        #search only by user's collection if a user is logged in
        if params[:user_id]
            @directors = Director.where(user_id: params[:user_id])
        else
            @directors = Director.all 
        end
    end

    def set_director
        @director = Director.find(params[:id])
        puts @director
    end

    private

    def director_params
        params.require(:director).permit(:name, :imdb_link, :img_url)
    end

end

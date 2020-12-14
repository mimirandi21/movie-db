class ActorsController < ApplicationController
    before_action :set_actor, only: [:show]

    def new
        @actor = Actor.new
    end

    def create
        hash = ImdbService.new
    end

    def index
        #search only by user's collection if a user is logged in
        if params[:user_id]
            @actors = Actor.where(user_id: params[:user_id])
        else
            @actors = Actor.all 
        end
    end

    def show
        
    end

    def set_actor
        @actor = Actor.find(params[:id])
        puts @actor
    end

    private

    def actor_params
        params.require(:actor).permit.
    end

end

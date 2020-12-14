class CollectionsController < ApplicationController
    before_action :set_collection, except: [:new, :create]
    before_action :set_user

    def new
        @collection = Collection.new
    end

    def create
        @collection = Collection.create(collection_params)
        if @collection.valid?
            session[:message] = "Your collection has been updated."
            
        else
            session[:message] = "Update failed.  Please try again."
        end
        redirect_to collection_movies_path(@collection)
    end

    def edit
    end

    def update
        @collection.update(collection_params)

    end

    def destroy
    end

    def set_collection
        @collection = Collection.find(params[:id])
        puts @collection
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

    def collection_params
        params.require(:collection).permit(:source, :user_rating, :notes, :private_notes, :user_id, :movie_id)
    end

end

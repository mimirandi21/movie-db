class WritersController < ApplicationController
    
    def create
        Writer.create(writer_params)
    end

    private

    def writer_params
        params.require(:writer).permit(:name, :img_url, :imdb_link)
    end
end
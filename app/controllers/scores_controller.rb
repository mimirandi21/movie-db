class SCoresController < ApplicationController
    
    def create
        Score.create(score_params)
    end

    private

    def score_params
        params.require(:score).permit(:score)
    end
end
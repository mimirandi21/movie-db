class YearsController < ApplicationController
    
    def create
        Year.create(year_params)
    end

    private

    def year_params
        params.require(:year).permit(:year)
    end
end
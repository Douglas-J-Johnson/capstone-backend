class AnalysesController < ApplicationController
    before_action :authenticate

    def create
        @analysis = Analysis.create(
            entry_id: params[:analysis][:entry_id],
            raw_results: params[:analysis][:raw_results]
        )

        byebug

        if(@analysis.invalid?)
            render json: {message: @analysis.errors.messages}, status: :bad_request
        else
            render json: {analysis: @analysis}, status: :created
        end 
    end

    # private

    # def analysis_params
    #     params.require(:analysis).permit(:raw_results, :entry_id)
    # end
end

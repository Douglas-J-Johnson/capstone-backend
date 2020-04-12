class EntriesController < ApplicationController
    before_action :authenticate

    def index
        @entries = Entry.all

        render json: {entries: @entries}, status: :ok
    end

    def show
        @entry = Entry.find(params[:id])

        if(!@entry)
            render json: {message: "Could not find entry."}, status: :not_found
        else
            render json: {entry: @entry}, status: :ok
        end
    end

    def create
        @entry = Entry.create(entry_params)

        if(!@entry)
            render json: {message: "Could not create entry."}, status: :bad_request
        else
            render json: {entry: @entry}, status: :created
        end 
    end

    def update
        @entry = Entry.find(params[:id])

        if(!@entry)
            render json: {message: "Could not find entry, update unsucessful."}, status: :not_found
        else
            if(@entry.update(entry_params))
                render json: {entry: @entry}, status: :ok
            else
                render json: {message: "Could not update entry."}, status: :bad_request
            end
        end  
    end

    def delete
        @entry = Entry.find(params[:id])

        if(!@entry)
            render json: {message: "Could not find entry, deletion unsucessful."}, status: :not_found
        else
            render json: {entry: @entry}, status: :ok
        end        
    end

    private

    def entry_params
        params.require(:entry).permit(:date, :text)
    end
end

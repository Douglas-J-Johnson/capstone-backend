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
        byebug
        @entry = Entry.create(
            date: entry_params[:date],
            text: entry_params[:text],
            user_id: @user.id  
        )

        if(@entry.invalid?)
            render json: {message: @entry.errors.messages}, status: :bad_request
        else
            render json: {entry: @entry}, status: :created
        end 
    end

    def update
        @entry = Entry.find(params[:id])

        if(!@entry)
            render json: {message: "Could not find entry, update unsucessful."}, status: :not_found
        else
            @entry.update(entry_params)

            if(@entry.invalid?)
                render json: {message: @entry.errors.messages}, status: :bad_request
            else
                render json: {entry: @entry}, status: :ok
            end
        end
    end

    def destroy
        @entry = Entry.find(params[:id])

        if(!@entry)
            render json: {message: "Could not find entry, deletion unsucessful."}, status: :not_found
        else
            if(!@entry.destroy)
                render json: {message: @entry.errors.messages}
            else
                render json: {message: "Successfully Deleted"}, status: :ok
            end
        end        
    end

    private

    def entry_params
        params.require(:entry).permit(:date, :text)
    end
end

class UsersController < ApplicationController
    def create
        @user = User.create(user_params)

        if (@user.invalid?)
            render json: {message: @user.errors.messages}, status: :bad_request
        else
            render json: {user: @user}, status: :created
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :password)
    end
end

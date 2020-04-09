class UsersController < ApplicationController
    def index
        if(!authenticate)
            render json: {users: User.all}, status: :ok
        end
    end

    def create
        @user = User.create(user_params)

        render json: {user: @user}, status: :created
    end

    private
    
    def user_params
        params.require(:user).permit([:username, :password])
    end
end

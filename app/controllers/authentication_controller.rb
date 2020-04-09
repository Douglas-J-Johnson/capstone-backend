class AuthenticationController < ApplicationController
    def login
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by({username: username})

        if !@user
            render json: {message: "Could not log in."}, status: :unauthorized
        else
            if !@user.authenticate(password)
                render json: {message: "Could not log in."}, status: :unauthorized
            else
                secret = Rails.application.secrets.secret_key_base
                payload = {user_id: @user.id}
                token = JWT.encode(payload, secret)
                render json: {token: token}, status: :accepted
            end
        end
    end
end

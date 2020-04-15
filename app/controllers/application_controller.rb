class ApplicationController < ActionController::API
    def authenticate
        authorization_header = request.headers[:authorization]
        
        if(!authorization_header)
            render json: {message: "Must be logged in."}, status: :unauthorized
            return false
        else
            token = authorization_header.split(' ')[1]

            secret = Rails.application.secrets.secret_key_base
            payload = JWT.decode(token, secret)[0]

            @user = User.find(payload["user_id"])
            if(!@user)
                render json: {message: "Must be logged in."}, status: :unauthorized
                return false
            else
                return true
            end
        end
    end
end

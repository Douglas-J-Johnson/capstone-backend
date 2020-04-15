class CredentialsController < ApplicationController
    before_action :authenticate

    def generate_service_token
        @credential = Credential.find_by(service_name: params[:service_name])

        if(!@credential)
            render json: {message: "Unknown API service requested."}, status: :not_found
        else
            response = Faraday.post('https://iam.cloud.ibm.com/identity/token') do |req|
                req.params['grant_type'] = 'urn:ibm:params:oauth:grant-type:apikey'
                req.params['apikey'] = @credential.api_key
                req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
                req.headers['Accept'] = 'application/json'
            end
            response_body = JSON.parse(response.body)

            if response.status != 200
                render json: {message: 'Could not generate token.'}, status: :bad_request
            else
                render json: {
                    iam_token: response_body['access_token'],
                    api_url: @credential.api_url
                }, staus: :ok
            end
        end
    end
end

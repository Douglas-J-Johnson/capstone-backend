Rails.application.routes.draw do
  resources :credentials
  resources :users, only: [:index, :create]
  post "login", to: "authentication#login"
  get "generate_service_token", to: "credentials#generate_service_token"
  get "get_service_credentials", to: "credentials#get_service_credentials"
end

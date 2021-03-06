Rails.application.routes.draw do
  resources :analyses, only: [:create, :update]
  resources :entries
  resources :users, only: [:create]
  post "login", to: "authentication#login"
  get "generate_service_token", to: "credentials#generate_service_token"
end

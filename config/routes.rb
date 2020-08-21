Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  resources :category do
    resources :recipes
  end
end

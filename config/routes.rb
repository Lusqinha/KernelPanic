Rails.application.routes.draw do
  get "/admin" => "sessions#new"
  resources :posts, param: :slug
  resource :session
  resource :registration, only: %i[new create]
  resources :passwords, param: :token

  root "posts#index"
end

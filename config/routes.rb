Rails.application.routes.draw do
  root to: "home#show"

  get '/posts_with_button', to: 'posts#index_with_button', as: 'posts_with_button'
  get "/auth/instagram", as: :instagram_login
  get "/auth/:provider/callback", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  resources :users, param: :username, only: [:show]
  resources :posts, only: [:show, :index]

end

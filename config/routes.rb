Rails.application.routes.draw do
  root to: "home#show"

  get "/auth/instagram", as: :instagram_login
  get "/auth/:provider/callback", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

end

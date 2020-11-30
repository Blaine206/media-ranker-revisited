Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Omniauth Login Route
  get "/auth/github", as: "github_login"

  # Omniauth Github Callback Route
  get "/auth/:provider/callback", to: "user#create"

  root "works#root"
  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"

  # If this find_user in the app controller?  @login_user?
  get "/user/current", to: "user#current", as: "current_user"

  resources :works
  post "/works/:id/upvote", to: "works#upvote", as: "upvote"

  resources :users, only: [:index, :show]
end

Rails.application.routes.draw do
  root "users#index"
  get "/signup", to: "users#new"
  get "/admin", to: "admin/base#home"
  get "/home", to: "static_pages#home"
  resources :users
end

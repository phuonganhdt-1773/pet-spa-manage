Rails.application.routes.draw do
  get "sessions/new"
  get "/signup", to: "users#new"
  get "/admin", to: "admin/posts#index", :as => "admin"
  get "/home", to: "static_pages#home"
  get "/login", to: "sessions#new"
  get "/about-us", to: "static_pages#about_us", :as => "about_us"
  get "/contact", to: "static_pages#contact", :as => "contact"
  post "/login", to: "sessions#create"
  post "/subscribe", to: "static_pages#order"
  delete "/logout", to: "sessions#destroy"
  root "static_pages#home"
  resources :users
  resources :account_activations, only: %i(edit)
  resources :password_resets, except: %i(index show destroy)
  resources :posts do
    resources :comments
  end
  resources :orders
  resources :order_details, only: %i(show)
  resources :services, only: %i(index show)
  namespace :admin do
    resources :comments
    resources :services
    resources :posts
    resources :users
    resources :pets
    resources :stats
    resources :orders
    resources :order_details
  end
end

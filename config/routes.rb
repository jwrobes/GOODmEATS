Rails.application.routes.draw do

  constraints Clearance::Constraints::SignedIn.new(&:admin?) do
    namespace :admin do
      resources :users
      root to: "users#index"
    end
    resource :new_restaurant_searches, only: [:show, :create]
    resources :restaurants, only: [:new]
  end

  root to: "restaurants#index"

  resources :restaurants, only: [:index]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
end

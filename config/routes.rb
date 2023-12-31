Rails.application.routes.draw do
  resources :categories
  get 'profiles/show'
  root to: 'posts#index'
  resources :likes
  resources :comments
  resources :posts do
    resources :comments
    collection do
      get :search
    end
  end
  resources :profiles, only: [:show]
  resources :notifications, only: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "up" => "rails/health#show", as: :rails_health_check
end

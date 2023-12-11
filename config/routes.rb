Rails.application.routes.draw do
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
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "up" => "rails/health#show", as: :rails_health_check
end

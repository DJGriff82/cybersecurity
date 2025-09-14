
 

# config/routes.rb
Rails.application.routes.draw do
  # Super user routes
  namespace :super do
  root to: 'dashboard#index'
  resources :companies
  resources :users
  resources :categories
  resources :courses do
    resources :training_modules do
      resources :training_module_pages
    end
  end
  get 'analytics', to: 'analytics#index'
end

  # Admin routes
  namespace :admin do
    root to: 'dashboard#index'
    resources :users
    resources :user_progress, only: [:index, :show]
    resources :reports, only: [:index]
  end

  # Staff routes
  resources :courses, only: [:index, :show] do
    resources :training_modules, only: [:show] do
      member do
        patch :update_progress
        post :complete
      end
    end
    resources :assessments, only: [:show, :create]
  end

  # Authentication
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
 

  root 'home#index'

end

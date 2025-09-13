#Rails.application.routes.draw do
  #devise_for :users
  #resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  #root "posts#index"
#end


# config/routes.rb
Rails.application.routes.draw do
  # Super user routes
  namespace :super do
    root 'dashboard#index'
    resources :companies
    resources :users
    resources :courses
    get 'analytics', to: 'analytics#index'
  end

  # Admin routes
  namespace :admin do
    root 'dashboard#index'
    resources :users
    resources :user_progress, only: [:index, :show]
    resources :reports, only: [:index]
  end

  # Staff routes
  resources :courses, only: [:index, :show] do
    resources :training_modules, only: [:show] do
      member do
        post :complete
        patch :update_progress
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
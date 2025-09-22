
 

# config/routes.rb
Rails.application.routes.draw do
  # Super user routes
    namespace :super do
    root to: 'dashboard#index'

    resources :companies do
      member do
        patch :restore   # adds /super/companies/:id/restore
      end

      # Nested company users management
      resources :users, controller: "company_users" do
        member do
          patch :restore   # adds /super/companies/:company_id/users/:id/restore
        end
      end
    end

    resources :users     # global users list for supers (if you still want this)
    resources :categories
    resources :courses do
      resources :training_modules do
        resources :module_pages
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
  resource :profile, only: [:edit, :update], controller: "users/profiles"
  resources :training_modules, only: [:show] do
    resources :module_pages, only: [:show], controller: "course_pages"

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

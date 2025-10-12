Rails.application.routes.draw do
  # ============================
  # SUPER USER ROUTES
  # ============================
  namespace :super do
    root to: 'dashboard#index'

    # --- Companies ---
    resources :companies do
      member do
        patch :restore   # /super/companies/:id/restore
      end

      # Nested company users management
      resources :users, controller: "company_users" do
        member do
          patch :restore   # /super/companies/:company_id/users/:id/restore
        end
      end
    end

    # --- Global Users (Super Admin Management) ---
    resources :users do
      member do
        patch :toggle_active   # /super/users/:id/toggle_active
      end
    end

    # --- Categories ---
    resources :categories

    # --- Courses, Training Modules, and Pages ---
    resources :courses do
      resources :training_modules do
        resources :module_pages
      end
    end

    # --- Analytics ---
    get 'analytics', to: 'analytics#index'
  end

  # ============================
  # ADMIN ROUTES
  # ============================
  namespace :admin do
    root to: 'dashboard#index'

    resources :users
    resources :user_progress, only: [:index, :show]
    resources :reports, only: [:index]
  end

  # ============================
  # STAFF ROUTES
  # ============================
  resource :profile, only: [:edit, :update, :destroy], controller: "users/profiles"

  # ============================
  # COURSES (Staff + General Access)
  # ============================
  resources :courses, only: [:index, :show] do
    resources :training_modules, only: [:show] do
      resources :module_pages, only: [:show], controller: "course_pages"

      member do
        patch :update_progress
        post :complete
      end
    end

    resources :assessments, only: [:show, :create]
  end

  # ============================
  # STATIC PAGES
  # ============================
  get "privacy", to: "home#privacy"

  # ============================
  # AUTHENTICATION (Devise)
  # ============================
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  # ============================
  # ROOT PATH
  # ============================
  root 'home#index'
end

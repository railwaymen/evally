Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope '(:locale)', locale: /en|pl/ do
    devise_for :users, skip: :all

    namespace :v2, defaults: { format: :json } do
      resource :session, controller: 'session', only: :create

      resources :invitations, only: %i[create update]
      resources :passwords, only: %i[create update]

      resource :dashboard, controller: 'dashboard', only: :show

      resources :evaluation_employables, only: %i[index create update destroy] do
        get :form, on: :collection
        get :draft, on: :member
      end

      resources :employees, only: %i[index show create update destroy] do
        collection do
          get :form
          get :skills
          get :search
          get :overview
          get :archived
        end

        member do
          put :archive
        end

        get '/evaluations/:id', to: 'evaluation_employables#completed'
      end

      resources :evaluation_recruitables, only: %i[create update destroy]

      resources :recruits, only: %i[show] do
        collection do
          post :webhook
        end

        resources :comments, only: %i[create update destroy] do
          collection do
            post :webhook
          end
        end

        resources :evaluation_recruitables, path: '/evaluations', only: %i[show]
      end

      resources :templates, only: %i[index show create update destroy]

      resources :notifications, only: :index do
        member do
          put :read
        end
      end

      resource :profile, controller: 'profile', only: %i[show update] do
        put :password, on: :member
      end

      resource :settings, only: :update
      resources :users, only: %i[index update] do
        collection do
          get :active
        end
      end

      namespace :browse do
        resources :employees, only: :show do
          resources :evaluations, only: :show
        end
      end
    end

    # Route to hit the Vue app
    get '/*path', to: 'pages#index', format: false

    # ONLY FOR ACTION MAILER PURPOSES
    resources :passwords, only: [] do
      get :reset, on: :collection
    end

    resources :invitations, only: [] do
      get :accept, on: :collection
    end
  end
end

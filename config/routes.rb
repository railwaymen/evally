Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope '(:locale)', locale: /en|pl/ do
    devise_for :users, skip: :all

    namespace :v2, defaults: { format: :json } do
      resource :session, controller: 'session', only: :create

      # resources :invitations, controller: 'invitations', only: %i[create update]
      resources :passwords, only: %i[create update]

      resource :dashboard, controller: 'dashboard', only: :show

      resources :drafts, only: %i[index show create update destroy]

      resources :employees, only: %i[index show create update destroy], shallow: true do
        get :skills, on: :collection
        get :search, on: :collection
        get :overview, on: :collection
        put :archive, on: :member

        resources :evaluations, only: :show
      end

      resources :templates, only: %i[index show create update destroy]

      resource :profile, controller: 'profile', only: %i[show update] do
        put :password, on: :member
      end

      resource :settings, only: :update
      resources :users, only: %i[index update]

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
  end
end

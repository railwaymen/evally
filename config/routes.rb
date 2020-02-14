Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope '(:locale)', locale: /en|pl/ do
    scope :v2, defaults: { format: :json } do
      resource :session, controller: 'rails_jwt_auth/sessions', only: %i[create destroy]
    end

    namespace :v2, defaults: { format: :json } do
      resource :dashboard, controller: 'dashboard', only: :show

      resources :drafts, only: %i[index show create update destroy]

      resources :employees, only: %i[index show create update destroy], shallow: true do
        get :skills, on: :collection
        get :search, on: :collection
        get :overview, on: :collection

        resources :evaluations, only: :show
      end

      resources :templates, only: %i[index show create update destroy]

      resource :profile, controller: 'profile', only: %i[show update] do
        put :password, on: :member
      end

      resource :settings, only: :update

      namespace :browse do
        resources :employees, only: :show do
          resources :evaluations, only: :show
        end
      end
    end

    # Route to hit the Vue app
    get '/*path', to: 'pages#index', format: false
  end

  # resources :invitations, controller: 'rails_jwt_auth/invitations', only: [:create, :update]
  # resource :password, controller: 'rails_jwt_auth/passwords', only: [:create, :update]
  # resource :confirmation, controller: 'rails_jwt_auth/confirmations', only: [:create, :update]
  # resource :registration, controller: 'rails_jwt_auth/registrations', only: [:create, :update, :destroy]
  # resource :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]
end

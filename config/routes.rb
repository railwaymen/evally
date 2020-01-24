Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  scope '(:locale)', locale: /en|pl/ do
    scope :v1, defaults: { format: :json } do
      resource :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]
    end

    namespace :v1, defaults: { format: :json } do
      resources :activities, only: [:index] do
        get 'today', on: :collection
      end

      resources :employees, only: [:index, :show, :create, :update, :destroy] do
        get 'chart', on: :collection
        post 'search', on: :collection
        get 'skills', on: :collection
      end

      resources :evaluations, only: [:index, :create, :update, :destroy]
      get 'employees/:id/evaluation', to: 'evaluations#evaluation', as: 'empoyee_evaluation'

      resources :templates, only: [:index, :create, :update, :destroy]

      resources :users, only: [:show, :update] do
        put 'password', on: :member
      end

      resources :settings, only: [:update]
    end

    namespace :v2, defaults: { format: :json } do
      resource :dashboard, controller: 'dashboard', only: :show

      resources :drafts, only: %i[index show create update destroy]
      resources :employees, only: %i[index]
      resources :templates, only: %i[index show create update destroy]
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

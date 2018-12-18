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

      resources :employees, only: [:index, :create, :update, :destroy]

      resources :evaluations, only: [:index, :create, :update, :destroy]
      get 'employees/:id/evaluation', to: 'evaluations#evaluation', as: 'empoyee_evaluation'

      resources :templates, only: [:index, :create, :update, :destroy]

      resources :users, only: [:show, :create, :update] do
        put 'password', on: :member
      end

      resources :settings, only: [:update]
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

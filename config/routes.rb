Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :v1, defaults: { format: :json } do
    resource :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]
  end

  namespace :v1, defaults: { format: :json } do
    resource :users, only: [:create]
  end


  root 'pages#index'

  get '*path', to: 'pages#index', constraints: -> (request) do
    !request.xhr? && request.format.html?
  end

  # resources :invitations, controller: 'rails_jwt_auth/invitations', only: [:create, :update]
  # resource :password, controller: 'rails_jwt_auth/passwords', only: [:create, :update]
  # resource :confirmation, controller: 'rails_jwt_auth/confirmations', only: [:create, :update]
  # resource :registration, controller: 'rails_jwt_auth/registrations', only: [:create, :update, :destroy]
  # resource :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]
end

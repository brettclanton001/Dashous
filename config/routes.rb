Rails.application.routes.draw do

  ## Public Pages
  root to: 'public#search'
  post '/', to: 'public#search'
  get '/t/:trade_request_slug', to: 'public#trade_request', as: :public_trade_request
  get '/p/:username', to: 'public#user_profile', as: :public_user_profile
  get :terms, to: 'public#terms'
  get :privacy, to: 'public#privacy'
  get :donate, to: 'public#donate'
  get :about, to: 'public#about'

  ## Devise
  devise_for :users, skip: [:sessions, :registrations, :confirmations, :passwords]
  as :user do
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via

    post 'signup', to: 'registrations#create', as: :user_registration

    get '/u/confirmation', to: 'devise/confirmations#show', as: :show_user_confirmation
    get '/u/confirmation/new', to: 'devise/confirmations#new', as: :new_user_confirmation
    post '/u/confirmation', to: 'devise/confirmations#create', as: :user_confirmation

    post '/u/password', to: 'devise/passwords#create', as: :user_password
    get '/u/password/new', to: 'devise/passwords#new', as: :new_user_password
    get '/u/password/edit', to: 'devise/passwords#edit', as: :edit_user_password
    patch '/u/password', to: 'devise/passwords#update', as: :patch_user_password
    put '/u/password', to: 'devise/passwords#update', as: :put_user_password
  end

  ## Authentication
  get :login, to: 'authentication#login', as: :new_user_session
  get :signup, to: 'authentication#signup', as: :new_user_registration

  ## API
  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create]
    end
  end

  ## User Restricted Area
  scope :u, module: :users do
    resources :trade_requests, only: [:index, :new, :edit, :create, :update] do
      patch :activate
      patch :disable
    end
    resources :offers, only: [:index, :new, :create]
    resource :account, only: [] do
      get :show
      patch :update
    end
    resources :reviews, only: [:create]
    namespace :trade_requests do
      resources :offers, only: [] do
        patch :approve
        patch :decline
      end
    end
  end

  ## Admin Routes
  authenticated :user, lambda {|u| u.admin? } do
    mount Resque::Server.new, :at => "/resque"
  end

end

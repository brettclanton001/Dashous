Rails.application.routes.draw do

  ## Public Pages
  root to: 'public#search'
  post '/', to: 'public#search'
  get '/t/:trade_request_slug', to: 'public#trade_request', as: :public_trade_request
  get '/p/:username', to: 'public#user_profile', as: :public_user_profile
  get :terms, to: 'public#terms'
  get :privacy, to: 'public#privacy'

  ## Devise
  devise_for :users, skip: [:sessions, :registrations]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
    get 'signup', to: 'registrations#new', as: :new_user_registration
    post 'signup', to: 'registrations#create', as: :user_registration
  end

  ## User Restricted Area
  scope :u, module: :users do
    resources :trade_requests, only: [:index, :new, :edit, :create, :update] do
      patch :activate
      patch :disable
    end
    resources :offers, only: [:index, :create]
    resources :account, only: [:index]
    resources :reviews, only: [:create]
    namespace :trade_requests do
      resources :offers, only: [] do
        patch :approve
        patch :decline
      end
    end
  end
end

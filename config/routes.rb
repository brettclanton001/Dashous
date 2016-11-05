Rails.application.routes.draw do
  devise_for :users
  root to: 'trade_requests#index'
  resources :trade_requests
end

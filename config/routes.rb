Rails.application.routes.draw do
  root to: 'trade_requests#index'
  resources :trade_requests
end

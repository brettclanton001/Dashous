Rails.application.routes.draw do
  devise_for :users
  root to: 'public#search'

  ## User Restricted Area
  scope :u, module: :users do
    resources :trade_requests
  end

end

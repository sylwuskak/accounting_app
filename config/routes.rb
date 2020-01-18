Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"

  resources :app_configurations, only: [:create, :index, :destroy, :update] do
    post 'copy'
  end

  resources :contributions, only: [:create, :index, :destroy, :update] do
  end

  resources :operations, only: [:create, :index, :destroy, :update] do
  end

  get 'income_tax', to: 'income_tax#get_income_tax', as: 'get_income_tax'
  get 'kpir', to: 'kpir#get_kpir', as: 'get_kpir'
end

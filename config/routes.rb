Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"

  resources :contributions, only: [:create, :index, :destroy, :update] do
  end

  resources :operations, only: [:create, :index, :destroy, :update] do
  end

  get 'income_tax', to: 'income_tax#get_income_tax', as: 'get_income_tax'
  get 'kpir', to: 'kpir#get_kpir', as: 'get_kpir'
  get 'kpir_by_month', to: 'kpir#get_kpir_by_month', as: 'get_kpir_by_month'
  get 'year_summary', to: 'kpir#year_summary', as: 'year_summary'
end

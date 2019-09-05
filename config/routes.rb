Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"

  resources :app_configurations, only: [:create, :index, :destroy, :update] do
    post 'copy'
  end

  resources :contributions, only: [:create, :index, :destroy, :update] do
  end
end

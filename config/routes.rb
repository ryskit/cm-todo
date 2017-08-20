Rails.application.routes.draw do

  scope module: :api do
    namespace :v1 do
      
      resources :tasks
      
      resources :users, only: [:create]
      get '/user', to: 'users#show'
      patch 'user', to: 'users#update'
      
    end
  end
end


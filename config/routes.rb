Rails.application.routes.draw do

  scope module: :api do
    namespace :v1 do
      
      resources :tasks
      post '/signup', to: 'users#create'
      
      patch '/settings/account', to: 'users#update_account'
      patch '/settings/password', to: 'users#update_password'
      
      namespace :auth do
        post '/authorize', to: 'users_authorization#authorize'
        post '/token', to: 'users_authorization#refresh_access_token'
        post '/revoke', to: 'users_authorization#revoke'
      end
      
    end
  end
end


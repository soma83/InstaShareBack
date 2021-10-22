Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      put '/login', to: 'users#login'
      put '/request', to: 'users#request_question'
      put '/respond', to: 'users#request_resp'
      put '/updatepsw', to: 'users#update_passw'
      put '/updatestatus', to: 'users#update_status'
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        resources :paths, only: [:index, :show, :create, :update, :destroy] do
          put '/rename', to: 'paths#rename_file'
          put '/change', to: 'paths#change_status'
          get '/download', to: 'paths#download'
        end
      end
    end
  end
end

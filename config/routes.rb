require 'sidekiq/web'

Rails.application.routes.draw do
  resources :services
  get '/scan', to: 'scans#index'
  post '/add_member_service', to: 'members#add_service'
  get '/delete_service/:id', to: 'members#delete_service'
  resources :members do 
    collection do
      get :import
      post :upload
      post :check
    end
  end
  resources :branches
  devise_for :users
  resources :home

  resources :imports do
    collection do
      post :upload_members
      get :export_qr
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end

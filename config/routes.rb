Rails.application.routes.draw do
  get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  resources :users do
    member do
      post :like, to: "users#like"
      post :follow, to: "users#follow"
      delete :unfollow, to: "users#unfollow"
      post :request_follow, to: "users#request_follow"
      delete :unrequest_follow, to: "users#unrequest_follow"
      post :accept_follow_request, to: "users#accept_follow_request"
      delete :deny_follow_request, to: "users#deny_follow_request"
      delete :remove_follower, to: "users#remove_follower"
    end
  end

  resources :comments

  resources :posts do
    resources :comments, only: [ :create, :destroy, :edit ]
    collection do
      get :search
    end
  end
end

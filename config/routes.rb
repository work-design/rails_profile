Rails.application.routes.draw do

  namespace :profiled, defaults: { business: 'profiled' } do
    resources :areas, only: [:index] do
      collection do
        get :search
        get :list
        post :follow
      end
    end

    namespace :admin, defaults: { namespace: 'admin' } do
      resources :profiles
      resources :addresses
    end

    namespace :panel, defaults: { namespace: 'panel' } do
      resources :areas
      resources :profiles do
        member do
          patch :user
          patch :qrcode
        end
      end
    end

    namespace :my, defaults: { namespace: 'my' } do
      resource :profile
      resources :addresses do
        collection do
          get :select
          get :list
          post :fork
          post :wechat
          post :program
          post :order
          post :order_from
          post :order_new
          post :order_create
          post :from_new
          post :from_create
        end
        member do
          patch :actions
          get :join
        end
      end
    end

    namespace :client, defaults: { namespace: 'client' } do
      resources :addresses do
        collection do
          get :select
          get :list
          post :fork
          post :wechat
          post :program
        end
        member do
          patch :actions
          get :join
        end
      end
    end
  end

end

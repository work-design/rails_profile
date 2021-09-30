Rails.application.routes.draw do

  namespace :profiled, defaults: { business: 'profiled' } do
    resources :areas, only: [:index] do
      collection do
        get :search
        get :list
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
          post :fork
          post :wechat
          post :program
        end
        member do
          get :join
        end
        resources :address_users
      end
    end
  end

end

Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    namespace :profiled, defaults: { business: 'profiled' } do
      resources :areas, only: [:index] do
        collection do
          get :search
          get :list
          post :follow
        end
      end
      resources :profiles, only: [] do
        member do
          get :qrcode
        end
      end

      namespace :admin, defaults: { namespace: 'admin' } do
        root 'home#index'
        resources :profiles
        resources :addresses
      end

      namespace :panel, defaults: { namespace: 'panel' } do
        resources :areas
        resources :addresses do
          collection do
            post :search
          end
        end
        resources :profiles do
          member do
            patch :user
            patch :qrcode
          end
        end
      end

      namespace :my, defaults: { namespace: 'my' } do
        resource :profile do
          member do
            get :qrcode
          end
        end
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
            get :join
          end
        end
      end

      namespace :our, defaults: { namespace: 'our' } do
        resources :addresses do
          collection do
            get :select
            get :list
            post :fork
            post :wechat
            post :program
          end
          member do
            get :join
          end
        end
      end
    end
  end
end

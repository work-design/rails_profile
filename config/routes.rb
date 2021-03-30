Rails.application.routes.draw do

  namespace :profiled, defaults: { business: 'profiled' } do
    resources :areas, only: [:index] do
      get :search, on: :collection
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
          get :fork
          post :wechat
        end
        member do
          get :join
        end
        resources :address_users
      end
    end
  end

end

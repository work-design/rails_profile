Rails.application.routes.draw do

  scope module: :profiled, defaults: { business: 'profiled' } do
    resources :areas, only: [:index] do
      get :search, on: :collection
    end
  end

  scope :panel, module: 'profiled/panel', as: :panel, defaults: { business: 'profiled', namespace: 'panel' } do
    resources :areas
    resources :profiles do
      member do
        patch :user
        patch :qrcode
      end
    end
  end

  scope :my, module: 'profiled/my', as: :my, defaults: { business: 'profiled', namespace: 'my' } do
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

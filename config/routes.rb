Rails.application.routes.draw do

  scope module: :profile do
    resources :areas, only: [:index] do
      get :search, on: :collection
    end
  end

  scope :panel, module: 'profile/panel', as: :panel do
    resources :areas
    resources :profiles do
      member do
        patch :user
        patch :qrcode
      end
    end
  end

  scope :my, module: 'profile/my', as: :my do
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

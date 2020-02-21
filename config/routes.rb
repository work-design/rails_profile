Rails.application.routes.draw do

  scope module: :profile do
    resources :areas, only: [:index] do
      get :search, on: :collection
    end
  end

  scope :admin, module: 'profile/admin', as: 'admin' do
    resources :areas
    resources :profiles do
      member do
        patch :user
        patch :qrcode
      end
    end
  end

  scope :my, module: 'profile/my', as: 'my' do
    resources :profiles
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

  scope :member, module: 'profile/membership', as: 'member' do
    resource :profile
  end

end

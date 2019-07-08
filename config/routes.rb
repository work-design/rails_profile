Rails.application.routes.draw do

  scope module: :profile do
    resources :areas, only: [:index] do
      get :search, on: :collection
    end
  end

  scope :admin, module: 'profile/admin', as: 'admin' do
    resources :addresses
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
    resources :addresses
  end

  scope :member, module: 'profile/member', as: 'member' do
    resource :profile
  end

end

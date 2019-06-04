Rails.application.routes.draw do

  scope module: :profile do
    resources :areas, only: [:index] do
      get :search, on: :collection
    end
  end

  scope :admin, module: 'profile/admin', as: 'admin' do
    resources :addresses
    resources :areas
    resources :profiles
  end

  scope :my, module: 'profile/my', as: 'my' do
    resources :profiles
    resources :addresses
  end


end

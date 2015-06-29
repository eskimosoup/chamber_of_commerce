Rails.application.routes.draw do
  get 'test', to: 'application#index', as: 'alternative'
  root to: 'application#index'

  mount Optimadmin::Engine => '/admin'
end
Optimadmin::Engine.routes.draw do
  resources :patrons, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'edit_images'
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
end

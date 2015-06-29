Rails.application.routes.draw do
  get 'test', to: 'application#index', as: 'alternative'
  root to: 'application#index'

  mount Optimadmin::Engine => '/admin'
end

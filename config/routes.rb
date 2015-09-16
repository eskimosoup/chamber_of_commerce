Rails.application.routes.draw do
  %w( 403 404 422 500 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  resources :article_categories, path: "article-category", only: :show
  resources :articles, only: [:index, :show]
  resources :article_categories, only: [:show], path: 'article-categories'
  resources :event_bookings, only: [], path: 'event-bookings' do
    resources :charges, only: [:new, :create]
  end
  resources :events, only: [:index, :show] do
    resources :event_bookings, path: 'event-bookings', only: [:new, :create]
    member do
      get 'thank-you'
    end
  end
  resources :magazines, only: [:index]
  resources :pages, only: [:show]
  resources :newsletter_signups, only: [:new, :create]
  resources :event_locations, only: [:show], path: 'event-locations'
  resources :member_password_resets, only: [:new, :create, :show], path: 'members-password-reset' do
    member do
      patch 'update', as: 'update'
    end
  end
  resources :member_logins, only: [:new, :create], path: 'members-login' do
    collection do
      get 'edit'
      patch 'update', as: 'update'
    end
  end

  get 'member-offers', as: 'members_offers', to: 'member_offers#main_index'

  resources :members, only: [:index, :show] do
    resources :member_offers, path: 'offers'

    collection do
      get 'a-to-z-directroy', to: 'members#directory', as: 'directory'
      get 'edit'
      patch 'update', as: 'update'
    end
  end
  resources :member_sessions, only: [], path: 'members-area' do
    collection do
      get 'login'
      post 'authenticate'
      get 'logout'
      get 'edit'
    end
  end


  # resources :members, only: :show do
  #  resources :member_offers
  # end


  root to: 'application#index'

  mount Optimadmin::Engine => '/admin'
end
Optimadmin::Engine.routes.draw do
  resources :event_offices, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :industries, except: [:show] do
    collection do
      post :order
      get :import_csv
      post :import
    end
    member do
      get 'toggle'
    end
  end
  resources :member_offers, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :members, except: [:show] do
    resources :member_logins, except: [:show] do
      collection do
        post 'order'
      end
      member do
        get 'toggle'
      end
    end
    collection do
      get :import_csv
      post 'order'
      post :import
    end
    member do
      get 'toggle'
    end
  end
  get 'article_category/show'

  resources :events, except: [:show], path: 'events-admin' do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
    resources :event_bookings, only: [:index, :show] do
      collection do
        post 'order'
        get 'event-agendas'
      end
      member do
        get 'toggle'
        post :refund
      end
    end
  end
  resources :event_agendas, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end

  resources :event_categories, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end

  resources :event_locations, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :newsletter_signups, except: [:show] do
    collection do
      post 'order'
      get :export_csv
    end
    member do
      get 'toggle'
    end
  end
  resources :additional_contents, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :articles, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :magazines, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :internal_promotions, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :article_categories, except: [:show] do
    collection do
      post 'order'
    end
  end
  resources :articles, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :categories, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :pages, except: [:show] do
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

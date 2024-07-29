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
  resources :event_groups, only: [:index, :show], path: 'event-groups'
  resources :events, only: [:index, :show] do
    resources :event_bookings, path: 'event-bookings', only: [:new, :create]
    member do
      get 'full'
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

  get 'members/shared-offer/:id', as: :members_shared_offer, to: 'member_offers#shared'

  resources :members, only: [:index, :show] do
    resources :member_offers, path: 'offers'

    collection do
      get 'a-to-z-directory', to: 'members#directory', as: 'directory'
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

  namespace :memberships do
    resources :groups, only: :show

    resources :enquiries, only: [:create]
    resources :payments, only: [:create, :edit, :update] do
      resources :charges, only: [:new, :create]

      get 'thank-you', to: 'payments#show', on: :collection
    end

    root to: 'homes#index'
  end

  root to: 'application#index'

  mount Optimadmin::Engine => '/admin'
end
Optimadmin::Engine.routes.draw do
  concern :imageable do
    member do
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end

  concern :orderable do
    collection do
      post 'order'
    end
  end

  concern :toggleable do
    member do
      get 'toggle'
    end
  end

  concern :publishable do |options|
    collection do
      resources :expired,
                as: "expired_#{options[:module]}",
                controller: "#{options[:module]}/expired"
      resources :scheduled,
                as: "scheduled_#{options[:module]}",
                controller: "#{options[:module]}/scheduled"
      resources :published,
                as: "published_#{options[:module]}",
                controller: "#{options[:module]}/published"
    end
  end

  namespace :memberships do
    resources :join_reasons, except: :show, concerns: %i[orderable toggleable imageable], path: 'join-reasons'
    resources :groups, except: :show, concerns: %i[orderable toggleable imageable]
    resources :packages, except: :show, concerns: %i[orderable toggleable]
    resources :enquiries, only: [:index, :show]
    resources :how_heards, except: [:show], concerns: %i[orderable toggleable], path: 'how-heards'
    resources :payments, only: [:index, :show, :update]
  end

  resources :advertisements, except: [:show] do
    concerns :imageable, :publishable, module: 'advertisements'
  end

  resources :event_offices, except: [:show], concerns: %i[orderable toggleable]
  resources :event_groups, except: [:show], concerns: %i[orderable toggleable], path: 'event-groups'

  resources :industries, except: [:show], concerns: %i[toggleable] do
    collection do
      post :order
      get :import_csv
      post :import
    end
  end

  resources :member_offers, except: [:show], concerns: %i[imageable orderable toggleable], path: 'member-offers'

  resources :members, except: [:show] do
    get 'logins-only', to: 'members#logins_only', on: :collection
    resources :member_logins, except: [:show] do
      collection do
        post 'order'
      end
      member do
        get 'toggle'
      end
    end
    collection do
      get '/destroy_non_csv_members', to: "members#destroy_non_csv_members", as: 'destroy_non_csv'
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
      get 'duplicate'
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
        get 'unpaid_or_refunded'
      end
      member do
        get 'resend-confirmation'
        get 'toggle'
        post :refund
        post :cancel
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
  resources :newsletter_signups, only: [:index, :destroy] do
    collection do
      post 'order'
      get :export_csv
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
    concerns :publishable, module: 'articles'
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

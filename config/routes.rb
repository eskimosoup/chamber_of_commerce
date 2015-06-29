Rails.application.routes.draw do
  root to: "application#index"
  
  mount Optimadmin::Engine => "/admin"
end

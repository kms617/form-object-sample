Rails.application.routes.draw do
  resources :profiles, except: :show
end

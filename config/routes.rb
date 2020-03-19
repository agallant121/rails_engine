Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit]
      # resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, except: [:new, :edit]
      # resources :merchants, only: [:index, :show, :create, :update, :destroy]
    end
  end
end

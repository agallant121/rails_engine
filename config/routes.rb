Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit] do
        scope module: 'items' do
          get "/merchant", to: "merchants#show"
        end
      end
      namespace :merchants do
        get "/find", to: "find#show"
      end
      resources :merchants, except: [:new, :edit] do
        scope module: 'merchants' do
          get "/items", to: 'items#index'
        end
      end
    end
  end
end

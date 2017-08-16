Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:index, :show]

      get 'merchants/find', to: 'merchants/find#show'

      resources :merchants, only: [:index, :show]
    end
  end
end

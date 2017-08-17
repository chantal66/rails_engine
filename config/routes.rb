Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
      end
      resources :items, only: [:index, :show]

      namespace :invoices do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :invoice_items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/random', to: 'random#show'
      end
      resources :invoice_items, only: [:index, :show]

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find_all#show'
        get '/random', to: 'random#show'
      end

      namespace :transactions do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end

      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end
end

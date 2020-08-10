Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :notes do
    collection do
      get :open_spreadsheet
    end
  end
  root :to => 'sessions#new'

end

Rails.application.routes.draw do
  resources :artists
  resources :comments
  resources :genres
  resources :tracks
  resources :playlists
  resources :users, only: [:index, :create, :destroy, :show, :edit]
  get '/signup', to: 'users#new', as: "signup"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

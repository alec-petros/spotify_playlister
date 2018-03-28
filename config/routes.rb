Rails.application.routes.draw do
  root to: 'playlists#index'
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
  get '/playlists/:id/generate', to: 'playlists#generate'
  post 'playlists/fix', to: 'playlists#fix'
  post 'playlists/:id/edit_fix', to: 'playlists#edit_fix'
  post 'playlists/:id/save', to: 'playlists#save'
  get '/auth/spotify/callback', to: 'users#spotify'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

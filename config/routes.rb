Rails.application.routes.draw do
  root to: 'registers#app'
  resources :registers
  # XXX temporarily not in use
  # get '/auth/:provider/callback' => 'sessions#create'
  # get '/signin' => 'sessions#new', :as => :signin
  # get '/signout' => 'sessions#destroy', :as => :signout
  # get '/auth/failure' => 'sessions#failure'
end

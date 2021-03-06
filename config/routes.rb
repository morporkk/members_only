Rails.application.routes.draw do

  root   "users#new"
  get    '/login',    to: "sessions#new"
  post   '/login',    to: "sessions#create"
  delete '/logout',   to: "sessions#destroy"
  resources :users
  resources :posts, only: %i[new create index]
end

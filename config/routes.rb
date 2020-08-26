Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :articles, only: [:index, :show]
  resources :words, only: [:create, :index]
  resources :flashcards, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :articles, only: [:index, :show]
  resources :words, only: [:create, :index]
  resources :flashcards, only: [:show, :index]
end

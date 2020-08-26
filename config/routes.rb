Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :articles, only: [:index, :show]
  resources :words, only: [:create, :index]
  resources :lists, only: :show
  resources :flashcards, only: [:show, :index]
  resources :articles, only: [:index, :show]
  resources :words, only: [:create, :index]
  patch '/flashcards/:id/mastered', to: 'flashcards#mastered', as: 'flashcard_mastered_update'
end

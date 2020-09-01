Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'

  get 'edit_topics', to: 'topics#edit'
  post 'edit_topics', to: 'topics#post'

  resources :articles, only: [:index, :show]
  resources :words, only: [:create, :index]
  resources :lists, only: [:show, :index] do
    get 'flashcards/:id/next', to: 'flashcards#next', as: 'next_flashcard'
  end
  patch '/flashcards/:id/mastered', to: 'flashcards#mastered', as: 'flashcard_mastered_update'
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'

  get 'edit_topics', to: 'topics#edit'
  post 'edit_topics', to: 'topics#post'

  resources :articles, only: [:index, :show]
  resources :words, only: [:create, :index]
  resources :lists, only: [:show, :index] do
    patch '/daily_reports/mark_a_day_as_done', to: 'daily_reports#mark_a_day_as_done'
  end
  post '/lists/revision_du_jour_new', to: 'lists#revision_du_jour_new'
  post '/lists/nouveaux_mots_new', to: 'lists#nouveaux_mots_new'
  patch '/flashcards/:id/mastered', to: 'flashcards#mastered', as: 'flashcard_mastered_update'
end

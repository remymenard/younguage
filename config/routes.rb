Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]

  as :user do
      get    "users/cancel",  to: "users/registrations#cancel",  as: 'cancel_user_registration'
      get    "users/sign_up", to: "users/registrations#new",     as: 'new_user_registration'
      get    "users/edit",    to: "users/registrations#edit",    as: 'edit_user_registration'
      patch  "users",         to: "users/registrations#update",  as: 'user_registration'
      put    "users",         to: "users/registrations#update"
      delete "users",         to: "users/registrations#destroy"
      post   "users",         to: "users/registrations#create"
  end

  root to: 'articles#index'

  get 'edit_topics', to: 'topics#edit'
  post 'edit_topics', to: 'topics#post'

  # STRIPE
  resources :subscriptions, only: :index
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end
  mount StripeEvent::Engine, at: '/stripe-webhooks'

  resources :articles, only: [:index, :show]
  get 'videos', to: 'videos#show'
  resources :words, only: [:create, :index]
  resources :lists, only: [:show, :index] do
    patch 'daily_reports/mark_a_day_as_done', to: 'daily_reports#mark_a_day_as_done'
  end
  post 'lists/revision_du_jour_new', to: 'lists#revision_du_jour_new'
  post 'lists/nouveaux_mots_new', to: 'lists#nouveaux_mots_new'
  patch 'flashcards/:id/mastered', to: 'flashcards#mastered', as: 'flashcard_mastered_update'

  require "sidekiq/web"
  authenticate :user, lambda { |u| true } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

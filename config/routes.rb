Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "guess_admin", to: "instas#guest_admin"
  get "guess", to: "instas#guest"
  devise_for :users
  get '/users_profil', to:'users#profil', as: 'profil'
  root 'instas#index'
  resources :publications do
    resources :comments
  end
  resources :likes, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  get '/publications_publication', to:'publications#publication', as: 'allpub'
  get '/publications_publi', to:'publications#publi', as: 'userpub'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

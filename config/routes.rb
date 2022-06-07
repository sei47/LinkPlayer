Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :participants, only:[:create, :destroy]
  resources :communities
  resources :games, only:[:new, :create]
  root 'communities#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

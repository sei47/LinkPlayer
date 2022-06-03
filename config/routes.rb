Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :communities
  root 'communities#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

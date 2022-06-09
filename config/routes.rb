Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :communities do
    member do
      resources :participants, only:[:create, :destroy]
    end
    resources :posts, only:[:new, :create]
  end
  resources :games, only:[:new, :create]
  root 'communities#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

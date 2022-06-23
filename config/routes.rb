Rails.application.routes.draw do
  get 'top/index'
  root 'top#index'
  # root 'communities/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    post 'users/admin_guest_sign_in', to: 'users/sessions#new_admin_guest'
  end
  resources :users, only:[:show]
  resources :messages, only:[:new, :create, :index]
  resources :friends, only:[:index, :new, :create, :destroy] do
    member do
      post :accept
    end
  end
  resources :communities do
    member do
      resources :participants, only:[:create, :destroy]
    end
    resources :posts, only:[:new, :create]
  end
  resources :games, only:[:new, :create]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

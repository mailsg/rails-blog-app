Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy]
  end
  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:create]
  end
  root 'users#index'
end

Rails.application.routes.draw do
  root :to => "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search", as: "search"

  devise_for :users

  resources :books, only: [:index, :show, :new, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]

    member do
      get :followings
      get :followers
    end
  end
end

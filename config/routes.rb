Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  get 'homes/top'
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:index,:edit,:update]
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do

    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end
    resources :book_comments, only: [:destroy]
  get 'home/about' => 'homes#about'

end
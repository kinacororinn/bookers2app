Rails.application.routes.draw do
  get 'searches/search'
  get 'searches/index'
  get 'searches/show'
  get 'relationships/index'
  get 'relationships/create'
  get 'relationships/destroy'
 
  get 'favorites/create'
  get 'favorites/destroy'
  get 'homes/top'
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:index,:edit,:update] do
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
 end

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do

    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end
    resources :book_comments, only: [:destroy]
  get 'home/about' => 'homes#about'
  get 'user/following/:id' => 'users#followings', as: 'following'
  get 'user/follower/:id' => 'users#followers', as: 'follower'
  get "search" => "searches#search"
end
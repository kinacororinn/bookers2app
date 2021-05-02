Rails.application.routes.draw do
  get 'homes/top'
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:index,:edit,:update]
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  get 'home/about' => 'homes#about'

end
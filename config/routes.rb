Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  resources :users do
    #resources :following, :followers
    get 'following' , to: 'users#following'
    get 'followers' , to: 'users#followers'
  end
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :microposts
  resources :users
  resources :relationships, only: [:create, :destroy]
end


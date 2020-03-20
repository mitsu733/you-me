Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about', to: "homes#about", as: "about"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  get '/search', to: "search#search", as: "search"

  get 'users/withdraw', to: 'users#withdraw',as: 'withdraw'
  resources :users, only: [:show, :edit, :update, :destroy] do
    resource :user_relationships, only: [:create, :destroy]
    get :followed, on: :member
    get :follower, on: :member
  end

  get '/infinite_scrolling', to: "pet_records#infinite_scrolling"
  get '/likes', to: 'likes#index',as: 'likes'
  get 'pet_records/tag', to: 'pet_records#tag',as: 'tag'
  resources :pet_records do
    resource :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

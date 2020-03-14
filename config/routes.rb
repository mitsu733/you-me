Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about_user', to: "homes#about_user", as: "about_user"
  get 'homes/about_record', to: "homes#about_record", as: "about_record"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  get '/search', to: "search#search", as: "search"

  get 'users/withdraw', to: 'users#withdraw',as: 'withdraw'
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resource :user_relationships, only: [:create, :destroy]
    get :followed, on: :member
    get :follower, on: :member
  end

  get '/likes', to: 'likes#index',as: 'likes'
  get 'pet_records/tag', to: 'pet_records#tag',as: 'tag'
  resources :pet_records do
    resource :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

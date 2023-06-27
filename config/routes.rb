Rails.application.routes.draw do

    devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  devise_for :users, controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  devise_scope :user do
    post "users/guest_sign_in",to: "public/sessions#guest_sign_in"
  end

  # urlにadminを含める
  namespace :admin do
    get "/" => "homes#top"
    resources :users, only: [:index,:show,:edit,:update,:destroy]
    resources :tags, only: [:index,:destroy]
    resources :dinners, only: [:show,:destroy] do
      resources :comments, only: [:destroy]
    end
 end

 # urlにpublicを含めない
 scope module: :public do
   root to: "homes#top"
    get "/about" => "homes#about"
    get '/search' => "searches#search"
    get "dinners/genre_search/:id" => "dinners#genre_search", as: 'genre_search'

    resources :users, only: [:index,:show,:edit,:update,:destroy] do
      resource :relationships, only: [:create,:destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      resources :meal_records, only: [:new,:create,:destroy]
      member do
        get "favorites" => "users#favorites"
      end
      collection do
        get "mypage" => "users#mypage"
        # get "search" => ""
      end
    end

    resources :dinners, only: [:index,:new,:create,:show,:edit,:update,:destroy] do
      collection do
        get "album" => "dinners#album"
      end
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end

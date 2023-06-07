Rails.application.routes.draw do

    devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  devise_for :users, controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  devise_scope :users do
    get '/admin/sign_out' => 'public/sessions#destroy'
  end

  # urlにadminを含める
  namespace :admin do
    get "/" => "homes#top"
    resources :users, only: [:index,:show,:edit,:update,:destroy]
    resources :tags, only: [:index,:create,:edit,:update]
    resources :dinners, only: [:index,:show,:destroy]
    resources :genres, only: [:index,:create,:edit,:update]
 end

 # urlにpublicを含めない
 scope module: :public do
   root to: "homes#top"
    get "/about" => "homes#about"

    resources :users, only: [:index,:show,:edit,:update,:destroy] do
      resource :relationships, only: [:create,:destroy]
      get "followings" => "relationship#followings", as: "followings"
      get "followers" => "relationship#followers", as: "followers"
      resources :meal_records, only: [:new,:create,:edit,:update,:destroy]
      member do
        get "mypage" => "users#mypage"
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

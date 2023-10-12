Rails.application.routes.draw do
  namespace :end_user do
    get 'searches/search'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # 管理者用devise

  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "end_user/registrations",
    sessions: "end_user/sessions"
  }
  # エンドユーザ用devise
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
   root to: 'homes#top'
   resources :end_users, only: [:show, :edit, :update]
  end

  scope module: :end_user do
   root to: 'homes#top'
   get 'end_users/confirm'
   patch 'end_users/withdraw'
   resources :end_users, only: [:index, :show, :edit, :update, :destroy] do
     resource :follows, only: [:create, :destroy]
  	 get "followings" => "follows#followings", as: "followings"
  	 get "followers" => "follows#followers", as: "followers"

     member do
       get :likes
     end
   end
   resources :post_contents, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
     resources :comments, only: [:create, :edit, :update, :destroy]
     resource :likes, only: [:create, :destroy]
   end
   resources :notifications, only: :index
   resources :events, only: [:index, :create, :show, :edit, :update, :destroy]
   resources :messages, only: [:index, :create, :edit, :update, :destroy]
  end
end



Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # 管理者用devise

  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "end_user/registrations",
    sessions: "end_user/sessions"
  }
  # ユーザ用devise
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end

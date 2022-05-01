Rails.application.routes.draw do
  
  
  # 管理者用
  namespace :admin do
    get 'orders/edit'
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
  end
  namespace :admin do
    get 'homes/top'
  end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  # 顧客用
  namespace :public do
    resources :addresses, only: [:index, :edit]
  end
  namespace :public do
    resources :orders, only: [:index, :new, :show, :log, :thanx]
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'items/index'
  end
  namespace :public do
    resources :addresses, only: [:show, :edit, :quit]
  end
  namespace :public do
    resources :addresses, only: [:index, :show]
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  #root to: "homes#top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

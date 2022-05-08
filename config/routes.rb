Rails.application.routes.draw do


  # 管理者用
  namespace :admin do
    resources :orders, only: [:edit, :update]
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
  namespace :admin do
    resources :order_details, only: [:update]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  # 顧客用
  namespace :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  namespace :public do
    get 'orders/log'
    get 'orders/thanx'
    resources :orders, only: [:index, :new, :show]
  end
  namespace :public do
    delete 'cart_items/all_destroy'
    resources :cart_items, only: [:index, :create, :update, :destroy]
  end
  namespace :public do
    resources :items, only: [:index, :show]
  end
  namespace :public do
    get 'customers/quit'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :customers, only: [:show, :edit]
  end
  namespace :public do
    resources :addresses, only: [:index, :show]
  end
  namespace :public do
    get 'homes/about'
  end
  root to: 'public/homes#top'

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  #root to: "homes#top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

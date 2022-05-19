Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

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

  #get URL => Controller#Action, as: 〇〇"_path"

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 顧客用
  get 'addresses' => 'public/addresses#index', as: 'public_addresses'
  post 'addresses' => 'public/addresses#create'
  get 'addresses/:id/edit' => 'public/addresses#edit', as: 'edit_public_address'
  patch 'addresses/:id' => 'public/addresses#update', as: 'public_address'
  delete 'addresses/:id' => 'public/addresses#destroy'

  post 'orders/log' => 'public/orders#log', as: 'public_orders_log'
  get 'orders/thanx' => 'public/orders#thanx', as: 'public_orders_thanx'
  get 'orders' => 'public/orders#index', as: 'public_orders'
  post 'orders' => 'public/orders#create'
  get 'orders/new' => 'public/orders#new', as: 'new_public_order'
  get 'orders/:id' => 'public/orders#show', as: 'public_order'

  delete 'cart_items/all_destroy' => 'public/cart_items#all_destroy', as: 'public_cart_items_all_destroy'
  get 'cart_items' => 'public/cart_items#index', as: 'public_cart_items'
  post 'cart_items' => 'public/cart_items#create'
  patch 'cart_items/:id' => 'public/cart_items#update', as: 'public_cart_item'
  delete 'cart_items/:id' => 'public/cart_items#destroy'

  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show', as: 'item'

  get 'customers/quit' => 'public/customers#quit', as: 'public_customers_quit'
  # 論理削除用のルーティング
  patch 'customers/:id/withdrawal' => 'public/customers#withdrawal', as: 'public_withdrawal'
  get 'customers/:id/edit' => 'public/customers#edit', as: 'edit_public_customer'
  patch 'customers/:id' => 'public/customers#update', as: 'public_customer'
  get 'customers/:id' => 'public/customers#show'

  get 'homes/about' => 'public/homes#about'
  root to: 'public/homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
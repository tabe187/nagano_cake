Rails.application.routes.draw do


  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }    
    
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }  

  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:new, :index, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module:  :public do
    resources :homes, only: [:top, :about]
    resources :items, only: [:index, :show]
    resources :addresses, only: [:new, :index, :update, :destroy, :create, :edit]
    resources :genres, only: [:show]
    
    delete "cart_items/destroy_all" => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
  
    get 'orders/confirm' => "orders#confirm"
    post 'orders/confirm' => "orders#confirm"
    get 'orders/thanks' => "orders#thanks"
    resources :orders, only: [:new, :index, :show, :create]

    root to: 'homes#top'
    get 'about' => "homes#about", as: "about"

    get 'customers/mypage' => "customers#show"
    get 'customers/edit' => "customers#edit"
    patch 'customers/edit' => "customers#update"
    get 'customers/mypage/withdrawal' => "customers#unsubscribe"
    patch 'customers/mypage/withdrawal' => 'customers#withdrawal'


  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

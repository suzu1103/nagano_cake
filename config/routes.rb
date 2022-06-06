Rails.application.routes.draw do

  root to: 'public/homes#top'
  get 'about' => "public/homes#about", as: "about"

  get 'admin' => "admin/homes#top", as: "admin"


  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  
  scope module: :public do
    resources :addresses, except: [:new, :show]
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    resource :customers, only: [:edit, :update] do
      collection do
        get 'my_page' => "customers#show"
        get 'confirm'
        patch 'withdraw'
      end
    end
  end

devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

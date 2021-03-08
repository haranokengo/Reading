Rails.application.routes.draw do
  # ファイル構成とurlも指定のパスにして管理者側がわかるようにnamespaceを使用
  namespace :admin do
    
    devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    passwords: 'admin/admins/passwords',
    registrations: 'admin/admins/registrations'
    }
    
    resources :gunres, only: [:new, :create, :edit, :update, :index]
    
    resources :users, only: [:index, :show]
  end
  
  # ファイル構成のみ指定のパスにするため、moduleを使用
  scope module: :public do
    
    root to: 'homes#top'
    
    get 'about' => 'homes#about'
    
    devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    passwords: 'public/users/passwords',
    registrations: 'public/users/registrations'
    }
    
    get 'books/search', to: "books#search"
    resources :books, only: [:new, :create, :edit, :update, :destroy, :show] do
      # bookに結びつけてネスト化
      resources :reviews, only: [:create, :destroy] do
        # reviewに結びつけている
        resources :posts, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
      end
    end
    resources :users, only: [:show, :edit, :update]
  end
  
end

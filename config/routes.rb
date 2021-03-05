Rails.application.routes.draw do
  
  namespace :admin do  # ファイル構成とurlも指定のパスにして管理者側がわかるようにnamespaceを使用
    
    devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    passwords: 'admin/admins/passwords',
    registrations: 'admin/admins/registrations'
    }
    
    resources :gunres, only: [:new, :create, :edit, :update, :index]
    
    resources :users, only: [:index, :show]
  end
  
  scope module: :public do  # ファイル構成のみ指定のパスにするため、moduleを使用
    
    root to: 'homes#top'
    
    get 'about' => 'homes#about'
    
    devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    passwords: 'public/users/passwords',
    registrations: 'public/users/registrations'
    }
    
    resources :books, only: [:new, :create, :edit, :update, :destroy]
  end
  
end

Rails.application.routes.draw do
  # ファイル構成とurlも指定のパスにして管理者側がわかるようにnamespaceを使用
  namespace :admin do
    devise_for :admins, controllers: {
      # 管理者はログイン画面のみ
      sessions: 'admin/admins/sessions',
    }
    resources :categories, only: [:create, :edit, :update, :index, :destroy]
    resources :users, only: [:index, :show]
  end

    root to: 'homes#top'

    get 'about' => 'homes#about'

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
    }

    get '/search' => 'searchs#search'
    get 'books/search' => 'books#search'
    get '/ranks' => 'ranks#index'

    resources :books, only: [:create, :edit, :update, :destroy, :show] do
      # bookに結びつけてネスト化
      # ネスト化が２階層で深くなっているためshallowオプションを使用して浅くしている
      resources :reviews, only: [:create, :destroy, :new], shallow: true  do
        # reviewに結びつけている
        resources :posts, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
      end
      resources :likes, only: [:create, :destroy]
    end

    resources :users, only: [:show, :edit, :update] do
      resources :likes, only: [:index]
      # フォローする
      post 'follow/:id' => 'relationships#follow', as: 'follow'
      # フォロー外す
      post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
      # memberメソッドを使うことによってuserを識別するためのIDを追加
      get :follower, on: :member
      get :followed, on: :member
    end

  end


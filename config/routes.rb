Rails.application.routes.draw do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  get '/search' => 'searchs#search'
  get 'books/search' => 'books#search'
  get '/ranks' => 'ranks#index'

  # ファイル構成とurlも指定のパスにして管理者側がわかるようにnamespaceを使用
  namespace :admin do
    devise_for :admins, controllers: {
      # 管理者はログイン画面のみ
      sessions: 'admin/admins/sessions',
    }
    resources :categories, only: [:create, :edit, :update, :index, :destroy]
    resources :users, only: [:index, :show]
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :books, only: [:create, :edit, :update, :destroy, :show],
                    param: :isbn, constraints: { code: /\d+/ } do
    # bookに結びつけてネスト化
    # ネスト化が２階層で深くなっているためshallowオプションを使用して浅くしている
    resources :reviews, only: [:create, :destroy, :new], shallow: true do
      # reviewに結びつけている
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :likes, only: [:index, :update]
    get 'likes/readed_all' => 'likes#readed_all'
    # フォローする
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    # フォロー外す
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    # memberメソッドを使うことによってuserを識別するためのIDを追加
    get :follower, on: :member
    get :followed, on: :member
  end
end

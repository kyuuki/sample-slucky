Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_page#root'
  # root to: 'static_page#root'  # 上記はこれの省略形

  get "under", to: "static_page#under"
  get "copyright", to: "static_page#copyright"
  get "tokushoho", to: "static_page#tokushoho"
  get "privacy", to: "static_page#privacy"
  get "terms", to: "static_page#terms"

  #
  # ユーザー登録
  #
  get "users/sign_up", to: "registering_users#new"
  get "users/confirm/:token", to: "registering_users#confirm", as: "users_confirm"
  resources :registering_users, only: [ :create ]

  #
  # ログイン
  #
  # users つけない方がいいかも。複数のログインとかあるシステムだと接頭辞ある方がいい
  get "users/log_in", to: "sessions#new"
  post "users/log_in", to: "sessions#create"
  get "users/log_out", to: "sessions#delete"

  #
  # パスワードリセット
  #
  # - edit, update の :id に当たる部分は token
  #
  #resources :password_resets, only: [:new, :create, :edit, :update]
  # 無理やり感が強い。RESTful と勘違いしそう。
  get "users/password_reset", to: "password_resets#new"
  post "users/password_reset", to: "password_resets#create"
  get "users/password_reset/input/:token", to: "password_resets#input", as: "users_password_reset_input"
  post "users/password_reset/update", to: "password_resets#update"

  #
  # Stripe 決済
  #
  get 'stripe', to: 'stripe#index'
  get 'stripe/create-checkout-session', to: 'stripe#create'
  get 'stripe/success', to: 'stripe#success'
  get 'stripe/portal', to: 'stripe#portal'
  post 'stripe/webhook', to: 'stripe#webhook'

  #
  # サービスページ
  #
  get 'services/:id', to: 'services#show'

  #
  # マイページ
  #
  get 'mypage', to: 'mypage#index'

  #
  # 管理画面
  #
  namespace 'admin' do
    root to: 'root#index'
    #
    # ログイン
    #
    # users つけない方がいいかも
    get "users/log_in", to: "sessions#new"
    post "users/log_in", to: "sessions#create"
    get "users/log_out", to: "sessions#delete"

    # 順番注意 /users/<log_in> で log_in が になる
    resources :users, only: [:index, :show]
    resources :articles
  end

  # https://github.com/fgrehm/letter_opener_web
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

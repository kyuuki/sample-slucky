Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_page#root'
  # root to: 'static_page#root'  # 上記はこれの省略形

  #
  # ユーザー登録
  #
  get "users/sign_up", to: "registering_users#new"
  get "users/confirm/:token", to: "registering_users#confirm", as: "users_confirm"
  resources :registering_users, only: [ :create ]

  #
  # ログイン
  #
  get "users/log_in", to: "sessions#new"
  post "users/log_in", to: "sessions#create"
  get "users/log_out", to: "sessions#delete"

  #
  # Stripe 決済
  #
  get 'stripe', to: 'stripe#index'
  get 'stripe/create-checkout-session', to: 'stripe#create'
  get 'stripe/success', to: 'stripe#success'
  post 'stripe/webhook', to: 'stripe#webhook'

  #
  # マイページ
  #
  get 'mypage', to: 'mypage#index'

  # https://github.com/fgrehm/letter_opener_web
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

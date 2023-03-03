class ApplicationController < ActionController::Base
  # https://qiita.com/you8/items/a98596547c12d844c53d
  helper_method :logged_in?, :current_user

  #
  # ログイン機能
  #
  # - TODO: 別ファイルにわける
  #
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def logged_in?
    # !!
    #!!session[:user_id]

    # TODO: Taiten にもバックポート
    # セッションがおかしくなった場合は↑だとダメ
    not current_user.nil?
  end

  def current_user
    return nil if session[:user_id].nil?

    # ||=
    @current_user ||= User.find_by(id: session[:user_id])

    @current_user
  end

  def authenticate_registrated_user!
    if not logged_in?
      flash[:alert] = "ログインしてください。"
      redirect_to users_log_in_url
    end
  end

  # 課金ユーザーかどうか
  def authenticate_paid_user!
    # 念のため
    if not logged_in?
      flash[:alert] = "ログインしてください。"
      redirect_to users_log_in_url
      return
    end

    # TODO: 有効期限を見るように
    # ユーザーの状態を確認
    service = Service.find_by(name: "有料サイト (サブスク)")
    subscription = Subscription.find_by(user_id: current_user.id, service_id: service.id)
    if subscription.nil?
      redirect_to stripe_url
      return
    end

    subscription_stripe = SubscriptionStripe.find_by(subscription_id: subscription.id)
    if subscription_stripe.nil? || subscription_stripe.status != "subscription"
      #flash[:alert] = "月額課金を登録してください。"
      redirect_to stripe_url
    end
  end
end

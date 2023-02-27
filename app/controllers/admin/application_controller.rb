class Admin::ApplicationController < ApplicationController
  layout "admin"

  before_action :authenticate_admin_user!

  #
  # ログイン機能
  #
  # - TODO: 別ファイルにわける
  #
  def admin_log_in(admin_user)
    session[:admin_user_id] = admin_user.id
  end

  def admin_log_out
    session[:admin_user_id] = nil
  end

  def admin_logged_in?
    # !!
    !!session[:admin_user_id]
  end

  def current_admin_user
    return nil if session[:admin_user_id].nil?

    # ||=
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id])

    @current_admin_user
  end

  # TODO: 本来、別管理ユーザーモデルを作るべき
  # Devise の authenticate_user! のまね
  def authenticate_admin_user!
    if not admin_logged_in?
      flash[:alert] = "ログインしてください。"
      redirect_to admin_users_log_in_url
      # https://qiita.com/yono@github/items/4de30dc084d97501108f
      # url か? path か?
    end
  end
end

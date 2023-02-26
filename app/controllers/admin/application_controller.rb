class Admin::ApplicationController < ApplicationController
  layout "admin"

  before_action :authenticate_admin_user!

  # TODO: 本来、別管理ユーザーモデルを作るべき
  # Devise の authenticate_user! のまね
  def authenticate_admin_user!
    u = current_user

    if u.nil? || u.email != "a@a.com"  # TODO: 現状これで登録してあったので
      flash[:alert] = "ログインしてください。"
      redirect_to users_log_in_url
    end
  end
end

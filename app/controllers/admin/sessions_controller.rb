#
# セッション (ログイン) コントローラー
#
class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :authenticate_admin_user!

  def new
    @form = LogInForm.new
  end

  def create
    @form = LogInForm.new(log_in_form_params)

    if not @form.valid?
      render :new
      return
    end

    admin_user = AdminUser.find_by(email: @form.email)
    #user_password_authentication = UserPasswordAuthentication.find_by(user: user)
    #user_password_authentication = UserPasswordAuthentication.joins(:user)
    #                                 .find_by(users: { email: @form.email })

    if admin_user.nil? || (not admin_user.authenticate(@form.password))
      # ログインエラー
      flash.now[:alert] = "メールアドレスまたはパスワードをご確認ください。"
      render :new
      return
    end

    admin_log_in(admin_user)

    # TODO: 現在表示しているページを保持するしくみ
    redirect_to admin_root_path, notice: "ログインしました。"
  end

  def delete
    admin_log_out

    # TODO: 現在表示しているページを保持するしくみ
    redirect_to admin_users_log_in_path, notice: "ログアウトしました。"
  end

  private
    def log_in_form_params
      params.require(:log_in_form).permit(:email, :password)
    end
end

#
# パスワードリセットコントローラー
#
# 完成度: 60% ぐらい
#
class PasswordResetsController < ApplicationController
  def new
    @form = PasswordResetsNewForm.new
  end

  def create
    @form = PasswordResetsNewForm.new(new_form_params)

    if not @form.valid?
      render :new
      return
    end

    # メールアドレスが存在していればトークン発行
    # TODO: 連続して行われる対策を (メール全体に対してもいえること)
    puts @form.email
    user = User.find_by(email: @form.email)
    if user.nil?
      flash.now[:alert] = "メールアドレスをご確認ください。"
      render :new
      return
    end

    # パスワードリセット中のチェック
    password_reset = PasswordReset.find_by(user: user)

    ActiveRecord::Base.transaction do
      # TODO: パスワードリセット中ならデータ削除
      unless password_reset.nil?
        password_reset.destroy!
      end

      # トークン生成
      # TODO: 以前は token_digest にしていたけどやめたから、Model をそのまま返していいかも。
      token = PasswordReset.create_and_return_token!(user)

      # メール送信
      UserMailer.password_reset(user, token).deliver_now
    end

    # TODO: 現在表示しているページを保持するしくみ
    redirect_to users_password_reset_url, notice: "登録されているメールアドレス宛にメールを送信しました。"
  end

  def input
    token = params[:token]

    password_reset = PasswordReset.find_by(token: token)

    if password_reset.nil?
      # TODO: ログは出しておくべき
      redirect_to root_path, alert: "URL をもう一度確認してください"  # TODO: メッセージ一元化
      return
    end

    @form = PasswordResetsInputForm.new
    @form.token = token
  end

  def update
    @form = PasswordResetsInputForm.new(input_form_params)

    # TODO: URL 違うから再読込とかおかしいことになりそう (GET と POST で URL を揃えておくのがかっこよさそう)
    if not @form.valid?
      render :input
      return
    end

    password_reset = PasswordReset.find_by(token: @form.token)
    if password_reset.nil?
      # TODO: かなりイレギュラー？すでに消されてる
      redirect_to root_path, alert: "最初から実行してください。"
      return
    end

    user_password_authentication = UserPasswordAuthentication.find_by(user: password_reset.user)
    # TODO: ない場合も考える
    if user_password_authentication.update(password: @form.password)
      # TODO: PasswordReset をトランザクションないで消すとよいかも。
      redirect_to root_path, alert: "パスワードを変更しました。"
    else
      # TODO: エラー処理
      redirect_to root_path, alert: "失敗しました。"
    end
  end

  private
    def new_form_params
      params.require(:password_resets_new_form).permit(:email)
    end

    def input_form_params
      params.require(:password_resets_input_form).permit(:password, :token)
    end
end

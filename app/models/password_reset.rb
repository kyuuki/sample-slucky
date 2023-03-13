class PasswordReset < ApplicationRecord
  belongs_to :user

  #
  # トークン生成 (DB 保存)
  #
  def self.create_and_return_token!(user)
    token = PasswordReset.new_token
    password_reset = PasswordReset.new(user: user, token: token)
    password_reset.save!

    token
  end

  # TODO: 文字数がわかれば、データベースの文字列の長さを制限した方がよい
  def self.new_token
    SecureRandom.urlsafe_base64
  end
end

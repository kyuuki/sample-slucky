# https://tech.mof-mof.co.jp/blog/rails-form-object/
class PasswordResetsInputForm
  include ActiveModel::Model

  # https://qiita.com/alpaca_taichou/items/bebace92f06af3f32898
  # attribute は 5.2 から
  #attribute :email, String
  #attribute :password, String
  attr_accessor :token, :password

  # TODO: Value Object 的な物もので共通化
  validates :token,
    presence: true
  validates :password,
    presence: true,
    length: { in: 6..255 }
end

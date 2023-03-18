#
# 登録中ユーザー
#
# - 純粋な登録するための情報のみを持つ
# - 複数の認証方法に対応するため、認証方法に関する情報は入れない
#
class RegisteringUser < ApplicationRecord
  validates :email,
    presence: true,
    length: { in: 3..254 },
    uniqueness: true
  #validates :nickname,
  #  presence: true,
  #  length: { in: 1..8 }  # TODO: 仮にめちゃくちゃ短いニックネームで Validtion

  # TODO: ここら辺の Validation はユーザーモデルと共用したい。Value Object が必要？
  # TODO: 内容は適当
  validates :name,
    presence: true,
    length: { in: 1..40 }
  validates :name_kana,
    presence: true,
    length: { in: 1..40 }
  validates :phone_number,
    presence: true,
    length: { in: 1..400 }
  validates :zipcode,
    presence: true,
    length: { in: 5..7 }
  validates :prefecture_id, presence: true
  validates :address,
    presence: true,
    length: { in: 1..400 }
  validates :birthday,
    presence: true

  # User に依存
  def to_user
    User.new(
      email: email,
      nickname: nickname,
      name: name,
      name_kana: name_kana,
      phone_number: phone_number,
      zipcode: zipcode,
      prefecture_id: prefecture_id,
      address: address,
      birthday: birthday)
  end
end

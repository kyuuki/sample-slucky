class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :prefecture

  validates :email,
    presence: true,
    length: { in: 3..254 },
    uniqueness: true
  # TODO: RegisteringUser と Validation 共有化したい
end

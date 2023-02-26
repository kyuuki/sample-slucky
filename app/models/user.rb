class User < ApplicationRecord
  has_one :user_stripe
  validates :email,
    presence: true,
    length: { in: 3..254 },
    uniqueness: true
  validates :nickname,
    presence: true,
    length: { in: 1..8 }
end

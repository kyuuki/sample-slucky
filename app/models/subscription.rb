class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :service
  has_many :subscription_valid_periods
end

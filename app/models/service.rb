class Service < ApplicationRecord
  has_one :service_stripe

  #
  # メインサービス取得
  #
  # 一つしかサービスがない前提の時に使う
  #
  def self.main
    # db/seeds.rb に依存
    service = Service.find_by(name: "有料サイト (サブスク)")

    if service.nil?
      raise "Cannot find main service"
    else
      return service
    end
  end

  #
  # このサービスにアクセスできるかどうか
  #
  def can_access?(user, now)
    subscription = Subscription.find_by(user: user, service: self)
    if subscription.nil?
      return false
    end

    subscription_validation = subscription.subscription_valid_periods.where("starts_at <= :now AND :now < expires_at", { now: now })

    case subscription_validation.size
    when 0
      return false
    when 1
      return true
    else
      # 複数の期間が被っていてもよしとする
      logger.warn "Subsctiption(#{subscription.id}) has multiple periods"
      return true
    end
  end
end

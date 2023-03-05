# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

service_free = Service.create(name: "無料サイト")
service_sub = Service.create(name: "有料サイト (サブスク)")
ServiceStripe.create(service: service_sub, stripe_price_identifier: "price_1MgWIiFrpPMjGfXT3RItyb3z")
service_one = Service.create(name: "有料サイト (買い切り)")

admin_user = AdminUser.create(email: "admin@a.com", password: "adminadmin")

# 無料会員
user = User.create(email: "free@a.com", nickname: "free")
user_password_authentication = UserPasswordAuthentication.create(
  user: user,
  password: "aaaaaa"
)

# 有料会員
user = User.create(email: "paid@a.com", nickname: "paid")
user_password_authentication = UserPasswordAuthentication.create(
  user: user,
  password: "aaaaaa"
)
subscription = Subscription.create(user: user, service: service_sub)
subscription_stripe = SubscriptionStripe.create(subscription: subscription, status: "subscription")  # TODO: stripe_customer_id
SubscriptionValidPeriod.create(
  subscription: subscription,
  starts_at: Time.zone.now,
  expires_at: Time.zone.now + 1.month
)
SubscriptionValidPeriod.create(
  subscription: subscription,
  starts_at: Time.zone.now + 1.month,
  expires_at: Time.zone.now + 2.month
)


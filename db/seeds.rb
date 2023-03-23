# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

service_free = Service.create(id: 1, name: "無料サイト")
service_sub = Service.create(id: 2, name: "有料サイト (サブスク)")
ServiceStripe.create(service: service_sub, stripe_price_identifier: "price_1MgWIiFrpPMjGfXT3RItyb3z")
service_one = Service.create(id: 3, name: "有料サイト (買い切り)")

admin_user = AdminUser.create(email: "admin@a.com", password: "adminadmin")

# 無料会員
user = User.create(
  email: "free@a.com",
  name: "山田無聊",
  name_kana: "ヤマダムリョウ",
  phone_number: "09099999999",
  zipcode: "1111111",
  prefecture_id: 1,
  address: "住所",
  birthday: "2000-01-01"
)
user_password_authentication = UserPasswordAuthentication.create(
  user: user,
  password: "aaaaaa"
)

# 有料会員
user = User.create(
  email: "paid@a.com",
  name: "佐藤裕亮",
  name_kana: "サトウユウリョウ",
  phone_number: "09099999999",
  zipcode: "1111111",
  prefecture_id: 1,
  address: "住所",
  birthday: "2000-01-01"
)
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


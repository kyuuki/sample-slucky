FactoryBot.define do
  factory :service_stripe do
    service { nil }
    stripe_price_identifier { "MyString" }
  end
end

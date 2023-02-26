FactoryBot.define do
  factory :user_stripe do
    user { nil }
    stripe_customer_identifier { "MyString" }
    status { "MyString" }
  end
end

FactoryBot.define do
  factory :subscription_stripe do
    subscription { nil }
    stripe_customer_identifier { "MyString" }
    status { "MyString" }
  end
end

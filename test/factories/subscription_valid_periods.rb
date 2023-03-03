FactoryBot.define do
  factory :subscription_valid_period do
    subscription { nil }
    starts_at { "2023-03-03 10:13:19" }
    expires_at { "2023-03-03 10:13:19" }
  end
end

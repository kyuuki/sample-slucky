FactoryBot.define do
  factory :user_valid_period do
    user { nil }
    starts_at { "2023-02-26 11:52:54" }
    expires_at { "2023-02-26 11:52:54" }
  end
end

FactoryBot.define do
  factory :password_reset do
    user { nil }
    token { "MyString" }
    sent_at { "2023-03-13 02:53:10" }
  end
end

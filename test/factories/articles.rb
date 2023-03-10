FactoryBot.define do
  factory :article do
    service { nil }
    title { "MyString" }
    video_tag { "MyText" }
    content { "MyText" }
    year { 1 }
    month { 1 }
  end
end

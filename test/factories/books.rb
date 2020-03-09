FactoryBot.define do
  factory :book do
    name { "MyString" }
    author { "MyString" }
    status { 1 }
    user { nil }
  end
end

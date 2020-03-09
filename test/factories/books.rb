FactoryBot.define do
  factory :book do
    name { Faker::Name.name }
    author { Faker::Name.name }
    status { 0 }
    user_id { User.all.sample.id }
  end
end

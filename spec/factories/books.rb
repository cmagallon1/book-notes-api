require 'faker'

FactoryBot.define do
  factory :book do
    name { Faker::Name.name }
    author { Faker::Name.name }
    user_id { User.all.pluck(:id).sample }
    category { Faker::Lorem.word }
  end
end

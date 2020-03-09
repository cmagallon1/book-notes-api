require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:username) { |n| "#{Faker::Name.initials(number: 5)}#{n}" }
    sequence(:email) { |n| "#{Faker::Internet.email}#{n}" }
    password { Faker::Lorem.characters(number: 10)  }
  end
end

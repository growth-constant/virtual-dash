# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    email { 'victor.j.fdez@gmail.com' }
    name { Faker::Name.first_name }
    password { 'password' }
    password_confirmation { 'password' }
    token { '5656828bbe02ea7ea866fd6cfff653134ecf6cb8' }
    refresh_token { '85bec5038af16939a5c5cff51991c5486deacaff' }
  end

  factory :race, class: Race do
    title { 'Test' }
    segment_id { '4677383' }
  end

  factory :race_category, class: RaceCategory do
    title { 'Mountain Bike' }
    price { 100 }
    race
  end

  factory :registration, class: Registration do
    race
    user
    race_category
    status { true }
  end
end

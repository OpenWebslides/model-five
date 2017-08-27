# frozen_string_literal: true

FactoryGirl.define do
  factory :gem do
    name { Faker::Name.name }
  end
end

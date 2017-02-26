# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "user#{n}#{n}@shitmail.com"
  end
  sequence :name do |n|
    "username#{n}#{n}"
  end
  factory :user do
    email
    name
    password '1234qwer'
    password_confirmation '1234qwer'
  end
end

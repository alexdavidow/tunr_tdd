FactoryGirl.define do
  factory :song do
    id 1
    artist
    album
    name Faker::Name.name
  end
end    
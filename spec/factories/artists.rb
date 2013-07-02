FactoryGirl.define do
  factory :artist do
    id 1
    name Faker::Name.name
    url 'http://queen.com'
  end
end
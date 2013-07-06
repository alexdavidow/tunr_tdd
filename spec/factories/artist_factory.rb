FactoryGirl.define do
  factory :artist, class: Artist do
    name Faker::Name.name
    url Faker::Internet.url
  end
  factory :artist2, class: Artist do

    name Faker::Name.name
    url Faker::Internet.url
  end
  factory :invalid_artist, class: Artist do
    name nil
    url nil
  end
  factory :updated_artist, class: Artist do
    name 'my updated name'
    url 'my updated url'
  end 
end
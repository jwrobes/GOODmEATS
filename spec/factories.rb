FactoryGirl.define do
  factory :source do
    name "Marin Sun Farms"
    url "http://marinsunfarms.com"
  end

  factory :meat do
    name "Beef"
  end

  factory :restaurant do
    name "Park burger"
    phone "1510555555"
    display_address ["1234 main st", "Neighborhood", "Oakland, CA 94606"]
    coordinate { { latitude: 37.8072590528299, longitude: -122.222015729986 } }
    sequence :api_id do |n|
      n
    end

    trait :with_source do
      after(:create) do |restaurant|
        restaurant.sources << create(:source)
      end
    end
  end
end

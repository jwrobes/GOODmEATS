FactoryGirl.define do
  factory :restaurant do
    name "Park burger"
    phone "1510555555"
    display_address ["1234 main st", "Neighborhood", "Oakland, CA 94606"]
    coordinate { { latitude: 37.8072590528299, longitude: -122.222015729986 } }
  end

  factory :source do
    name "Marin Sun Farms"
  end

  factory :meat do
    name "Beef"
  end
end

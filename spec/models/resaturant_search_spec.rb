require "rails_helper"

describe RestaurantSearch do
  include YelpApiHelper

  it "should be ActiveModel - complient" do
    restaurant_search = RestaurantSearch.new

    expect(restaurant_search).to be_a(ActiveModel::Model)
  end

  describe "#results" do
    context "with query params" do
      context "two yelp results and only one with goodmeat" do
        it "should return only the one matching goodmeat restaurant result" do
          matching_goodmeat_restaurant = create(:restaurant, api_id: "park-burger-oakland")
          not_matching_goodmeat_restaurant = build(:restaurant, name: "blah", api_id: "blah")
          stub_yelp_api_request_for_restaurants(matching_goodmeat_restaurant,
                                                not_matching_goodmeat_restaurant)

          results = RestaurantSearch.new(query).results

          expect(results.first.name).to eq(matching_goodmeat_restaurant.name)
          expect(results.count).to eq(1)
        end
      end
    end

    context "with query params not set" do
      it "should return nil" do
        results = RestaurantSearch.new.results

        expect(results).to eq(nil)
      end
    end
  end

  def query
    { location: "94611" }
  end
end

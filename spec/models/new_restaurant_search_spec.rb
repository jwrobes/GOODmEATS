require "rails_helper"

describe NewRestaurantSearch do
  include YelpApiHelper

  it "should be ActiveModel - complient" do
    new_restaurant_search = NewRestaurantSearch.new

    expect(new_restaurant_search).to be_a(ActiveModel::Model)
  end

  describe "#results" do
    context "with query params" do
      it "should return parsed results" do
        stub_yelp_api_request

        results = NewRestaurantSearch.new(query).results

        expect(results.first).to eq(result)
      end
    end

    context "with query params not set" do
      it "should return nil" do
        results = NewRestaurantSearch.new.results

        expect(results).to eq(nil)
      end
    end
  end

  def result
    OpenStruct.new(parsed_result)
  end

  def parsed_result
    {
      name: "Park Burger",
      api_id: "park-burger-oakland",
      display_address: ["4218 Park Blvd", "Glenview", "Oakland, CA 94602"],
      coordinate: {
        latitude: 37.8072590528299,
        longitude: -122.222015729986
      },
      phone: "5104791402"
    }
  end

  def query
    { query: "Park burger", location: "94611" }
  end
end

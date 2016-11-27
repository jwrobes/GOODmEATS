require "rails_helper"

describe YelpService do
  include YelpApiHelper
  describe "#search" do
    it "returns a restaurant search hash" do
      stub_yelp_api_request
      expect(YelpService.search(query: "Park burger", location: "94611")).
        to eq([parsed_restaurant_result])
    end
    it "skips restaurant result if missing any required info" do
      stub_yelp_api_request_with_invalid_restaurant_result
      empty_results = []
      expect(YelpService.search(query: "Park burger", location: "94611")).
        to eq(empty_results)
    end
  end
end

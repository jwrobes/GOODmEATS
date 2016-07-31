require "rails_helper"

describe YelpService do
  include YelpApiHelper
  describe "#search" do
    it "returns a restaurant search hash" do
      stub_yelp_api_request
      expect(YelpService.search(query: "Park burger", location: "94611")).
        to eq([parsed_restaurant_result])
    end
  end
end

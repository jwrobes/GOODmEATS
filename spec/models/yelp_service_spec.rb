require "rails_helper"

describe YelpService do
  include YelpApiHelper
  describe "#new" do
    context "with no results limit argument" do
      it "sets limit to default value" do
        yelp_service = YelpService.new(query: "blah")
        expect(yelp_service.limit).to eq(YelpService::DEFAULT_RESULTS_LIMIT)
      end
    end

    context "with results limit argument" do
      it "sets limit to argument value value" do
        limit_value = 10
        yelp_service = YelpService.new(query: "blah", limit: limit_value)
        expect(yelp_service.limit).to eq(limit_value)
      end
    end
  end
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

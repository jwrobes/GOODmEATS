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
      it "sets limit to argument value" do
        limit_value = 10
        yelp_service = YelpService.new(query: "blah", limit: limit_value)
        expect(yelp_service.limit).to eq(limit_value)
      end
    end

    context "with no offset" do
      it "sets offset to nil" do
        yelp_service = YelpService.new(query: "blah")
        expect(yelp_service.offset).to eq(nil)
      end
    end

    context "with offset argument" do
      it "sets offset to argument value" do
        offset = 40
        yelp_service = YelpService.new(query: "blah", offset: offset)
        expect(yelp_service.offset).to eq(offset)
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
    context "with an offset" do
      it "should return the restaurants after the offset" do
        restaurant = build(:restaurant)
        parsed_restaurant_result = build_parsed_restaurant_result(restaurant)
        stub_yelp_api_request_with_query_and_offset("Park burger", 40, restaurant)
        expect(YelpService.search(query: "Park burger", location: "94611", offset: 40)).
          to eq([parsed_restaurant_result])
      end
    end
  end
end

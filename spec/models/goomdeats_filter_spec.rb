require "rails_helper"

describe GoodmeatsFilter do
  describe "#filter" do
    context "with one goodmeat restaurant in search results" do
      it "should return one search result" do
        create(:restaurant, api_id: "matching-api-id")
        result_with_goodmeat = build(:restaurant_search_result,
                                     api_id: "matching-api-id")
        result_without_goodmeat = build(:restaurant_search_result,
                                        api_id: "non-matching-api-id")
        results = [result_with_goodmeat, result_without_goodmeat]

        expect(GoodmeatsFilter.new.filter(results)).to eq([result_with_goodmeat])
      end
    end
    context "with no goodmeat restaurant in search results" do
      it "should return empty array" do
        result_without_goodmeat = build(:restaurant_search_result,
                                        api_id: "non-matching-api-id")
        results = [result_without_goodmeat]

        expect(GoodmeatsFilter.new.filter(results)).to eq([])
      end
    end
  end
end

require "rails_helper"

describe RestaurantSearchResult do
  it "should be ActiveModel - complient" do
    restaurant_search_result = RestaurantSearchResult.new

    expect(restaurant_search_result).to be_a(ActiveModel::Model)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:api_id) }
  it { should validate_presence_of(:display_address) }
  it { should validate_presence_of(:coordinate) }
  it { should validate_presence_of(:phone) }
end

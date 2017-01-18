require "rails_helper"

feature "visitor searches for goodmeat restaurants by zipcode" do
  include YelpApiHelper

  scenario "finds a goodmeat restaurant" do
    visit root_path
    match_restaurant = create(:restaurant)
    not_match_restaurant = create(:restaurant, api_id: "blah-1", name: "blah 1")
    stub_yelp_api_request_for_restaurants(match_restaurant, not_match_restaurant)

    fill_in_search

    within ".search-results-content" do
      expect(page).to have_css "ul.search-results"
      expect(page).to have_css "li.search-result"
      expect(page).to have_css ".search-result > .name", text: match_restaurant.name
    end
  end

  scenario "finds a goodmeat restaurant in second api response" do
    visit root_path
    yelp_restaurant_response = parsed_restaurant_result
    match_restaurant = create(:restaurant)
    not_match_restaurant_1 = build(:restaurant, api_id: "blah", name: "blah")
    not_match_restaurant_2 = build(:restaurant, api_id: "blah2", name: "blah2")
    stub_yelp_api_request_for_restaurants(not_match_restaurant_1, not_match_restaurant_2)
    stub_yelp_api_request_for_restaurants_with_offset(40, match_restaurant)

    fill_in_search

    within ".search-results-content" do
      expect(page).to have_css "ul.search-results"
      expect(page).to have_css "li.search-result"
      expect(page).to have_css ".search-result > .name", text: match_restaurant.name
    end

  end

  scenario "does not find a restaurant" do
    pending "not completed yet"
    fail
    # visit root_path
    # stub_yelp_api_request_for_zipcode_without_goodmeat_restaurant

    # within ".search-results-content" do
    #   expect(page).to have_css "ul.search-results"
    #   expect(page).to have_css "li.no-search-result"
    # end
  end

  def fill_in_search
    within ".new_restaurant_search" do
      fill_in "Location", with: "94611"
      click_on "Search"
    end
  end
end

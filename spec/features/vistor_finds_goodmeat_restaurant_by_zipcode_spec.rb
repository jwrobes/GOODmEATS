require "rails_helper"

feature "visitor searches for goodmeat restaurants by zipcode" do
  include YelpApiHelper

  scenario "finds a goodmeat restaurant" do
    visit root_path
    yelp_restaurant_response = parsed_restaurant_result
    restaurant = create(:restaurant,
                        api_id: yelp_restaurant_response[:api_id])
    stub_yelp_api_request_with_one_result_matching_goodmeat_and_one_not

    fill_in_search

    within ".search-results-content" do
      expect(page).to have_css "ul.search-results"
      expect(page).to have_css "li.search-result"
      expect(page).to have_css ".search-result > .name", text: restaurant.name
    end
  end

  scenario "does not find a restaurant" do
    pending "not completed yet"
    fail
    visit root_path
    # stub_yelp_api_request_for_zipcode_without_goodmeat_restaurant

    within ".search-results-content" do
      expect(page).to have_css "ul.search-results"
      expect(page).to have_css "li.no-search-result"
    end
  end

  def fill_in_search
    within ".new_restaurant_search" do
      fill_in "Location", with: "94611"
      click_on "Search"
    end
  end
end

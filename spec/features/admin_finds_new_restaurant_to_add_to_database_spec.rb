require "rails_helper"

feature "admin searches for new restaurant to add to GoodMeatz" do
  include YelpApiHelper

  scenario "gets 404 on find new restaurant page if not an admin" do
    expect do
      visit admin_new_restaurant_searches_path
    end.to raise_error(ActionController::RoutingError)
  end
  scenario "successfully" do
    admin = create(:admin)
    sign_in_with(admin.email, admin.password)
    visit admin_new_restaurant_searches_path
    stub_yelp_api_request

    within ".new_admin_new_restaurant_search" do
      fill_in "Query", with: "Park burger"
      fill_in "Location", with: "94611"
      click_on "Search"
    end
    click_on_search_result

    expect(current_path).to eq(new_admin_restaurant_path)
    expect(page).to have_css "h2", text: "Park Burger"
    expect(page).to have_css ".new-restaurant-address",
                             text: "4218 Park Blvd Glenview Oakland, CA 94602"
  end

  def click_on_search_result
    find(".new-restaurant").find(".title a").click
  end
end

require "rails_helper"

feature "Vistor views goodmeat restaurant" do
  scenario "successfully" do
    restaurant = create(:restaurant, :with_source)

    visit restaurant_path(restaurant)

    expect(page).to have_css "h1", text: restaurant.name
    expect(page).to have_css ".contact", text: restaurant.display_address.first
    expect(page).to have_css ".sources"
    within ".sources" do
      expect(page).to have_css ".sources__header", text: "Sources"
      expect(page).to have_css ".source", text: restaurant.sources.first.name
    end
  end
end

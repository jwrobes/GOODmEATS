require "rails_helper"

feature "Vistor views goodmeat restaurant" do
  scenario "successfully" do
    restaurant = create(:restaurant, :with_source)

    visit restaurant_path(restaurant)

    expect(page).to have_css "h1", text: restaurant.name
    expect(page).to have_css ".contact", text: restaurant.display_address.first
    expect(page).to have_css ".sources"
    source_name = restaurant.sources.first.name

    within ".sources" do
      expect(page).to have_css ".sources__header", text: "Sources"
      expect(page).to have_css ".source", text: source_name
    end
    navigate_to_source(source_name)
    expect(page).to have_css "h1", text: source_name
  end

  def navigate_to_source(source_name)
    page.click_on(source_name)
  end
end

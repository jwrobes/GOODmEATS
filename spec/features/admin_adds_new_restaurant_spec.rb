require "rails_helper"

feature "Admin add new restaurant to goodmeats" do
  scenario "gest 404 on add new restaurant page if not and admin" do
    expect do
      visit new_admin_restaurant_path
    end.to raise_error(ActionController::RoutingError)
  end

  scenario "successfully with both source and meat" do
    source = create(:source)
    meat = create(:meat)
    admin = create(:admin)
    sign_in_with(admin.email, admin.password)
    visit new_admin_restaurant_path(new_restaurant_params)

    within "#new_restaurant" do
      select source.name, from: "restaurant_source_ids"
      select meat.name, from: "restaurant_meat_ids"
      click_on "Submit"
    end

    expect(current_path).to eq(admin_restaurants_path)
    within "tbody" do
      expect(page).to have_css ".table__row > td", text: new_restaurant_result.name
      expect(page).to have_css ".table__row > td", text: source_text
      expect(page).to have_css ".table__row > td", text: meat_text
    end
  end

  def new_restaurant_params
    { result: new_restaurant_result.to_h }
  end

  def source_text
    "1 source"
  end

  def meat_text
    "1 meat"
  end
end

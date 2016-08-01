require "rails_helper"

feature "Admin creates new source" do
  scenario "receives 404 if not admin" do
    expect do
      visit new_admin_source_path
    end.to raise_error(ActionController::RoutingError)
  end

  scenario "successfully" do
    admin = create(:admin)
    visit new_admin_source_path(as: admin)
    source = build(:source)

    within "#new_source" do
      fill_in "Name", with: source.name
      fill_in "Url", with: "www.marinsunfarm.com"
      click_on "Create Source"
    end

    visit admin_sources_path
    expect(page).to have_content source.name
  end

  scenario "and edits source" do
    admin = create(:admin)
    source = create(:source)
    visit admin_source_path(source, as: admin)
    expect(page).to have_content "Marin Sun Farms"

    edit_source

    visit admin_sources_path
    expect(page).to have_content "Updated name"
  end

  def edit_source
    click_on "Edit"
    within ".form" do
      fill_in "Name", with: "Updated name"
      click_on "Update Source"
    end
  end
end

require "rails_helper"

feature "visitor visits source page" do
  scenario "successfully" do
    source = create(:source)
    visit source_path(source)

    expect(page).to have_css "h1", text: source.name
    expect(page).to have_css "a", text: "Webpage"
  end
end

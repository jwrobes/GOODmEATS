# frozen_string_literal: true
require "rails_helper"

feature "visitor sees list of restaurants" do
  scenario "successfully" do
    Restaurant.create!(name: "Park burger")

    visit root_path

    expect(page).to have_css ".restaurants li", text: "Park burger"
  end
end

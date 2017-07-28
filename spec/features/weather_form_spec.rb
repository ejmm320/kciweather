require "rails_helper"

RSpec.feature "Weather Form Behaviour", :type => :feature do
  scenario "1) User wants to get a random weather" do
    visit "/weather/new"

    #fill_in "Name", :with => "My Widget"
    click_button "Get Random Weather"
    expect(page).to have_text("Someplace in the world has this weather: ")
    expect(page).to have_text("How cool is this?")
  end

  scenario "2) User wants to get the weather from some City in some Country" do
    visit "/weather/new"
    fill_in "Country", with: "de"
    fill_in "City", with: "Berlin"
    click_button "Get Weather"
    expect(page).to have_text("The current weather of Berlin is:")
    expect(page).to have_text("How cool is this?")
  end
end
require "rails_helper"

# OpenWeather API works this way:
# - If you send only the city data it looks for the weather no matter which country provide.
# - If you send info about the country regardless of the city it show the weather from the capital
RSpec.feature "Weather Form Behaviour", :type => :feature do
  scenario "1) User wants to get a random weather" do
    visit "/weather/new"
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

  scenario "3) User wants to get the weather from some City but doesn't fill city input", js: true do
    visit "/weather/new"
    fill_in "Country", with: "es"
    click_button "Get Weather"
    expect(page).to have_text("Please Provide a City")
  end
end
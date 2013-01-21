require "spec_helper"

feature "Authentication" do
  scenario "logging in with Facebook" do
    visit root_path
    click_on "Log in with Facebook"
    expect(page).to have_content("Log out")
  end

  scenario "logging in with Twitter" do
    visit root_path
    click_on "Log in with Twitter"
    expect(page).to have_content("Log out")
  end

  scenario "logging in with Google" do
    visit root_path
    click_on "Log in with Google"
    expect(page).to have_content("Log out")
  end

  scenario "changing user name" do
    visit root_path
    click_on "Log in with Facebook"
    click_on "Bongo"
    fill_in "user_name", with: ""
    click_on "Update"
    expect(page).to have_content("Name can't be blank")
    fill_in "user_name", with: "Max Measles"
    click_on "Update"
    expect(page).to have_content("Max Measles")
  end
end

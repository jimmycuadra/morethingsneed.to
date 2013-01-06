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

  scenario %{
    registering and logging in with a username and password
  }, disable_omniauth_test_mode: true do
    visit root_path
    click_on "Log in with your email address"
    click_on "Register" # Go to the registration page.
    click_on "Register" # Submit the form without filling it in.
    expect(page).to have_content("Name can't be blank")
    fill_in "name", with: "Bongo"
    fill_in "email", with: "bongo@example.com"
    fill_in "password", with: "password"
    fill_in "password_confirmation", with: "password"
    click_on "Register"
    click_on "Log out"
    click_on "Log in with your email address"
    click_button "Log in" # Submit the form without filling it in.
    expect(current_url).to eql(root_url) # Redirected to the root on failure.
    click_on "Log in with your email address"
    fill_in "auth_key", with: "bongo@example.com"
    fill_in "password", with: "password"
    click_button "Log in"
    expect(page).to have_content("Log out")
  end
end

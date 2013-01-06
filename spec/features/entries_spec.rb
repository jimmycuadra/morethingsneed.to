require "spec_helper"

feature "Entries", js: true do
  scenario "adding a new entry" do
    visit root_path
    click_on "Log in with Facebook"
    fill_in "entry_noun", with: "foo"
    select "needs", from: "entry_needs"
    fill_in "entry_verb", with: "bar"
    click_on "This needs to happen"
    expect(page).to have_content("More foo needs to bar.")
  end
end

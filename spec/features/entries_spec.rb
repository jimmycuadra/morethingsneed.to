require "spec_helper"

feature "Entries", js: true do
  scenario "adding new entries" do
    visit root_path
    click_on "Log in with Facebook"
    click_on "This needs to happen" # Submit without filling in the form.
    expect(page).to have_content("Noun can't be blank")
    fill_in "entry_noun", with: "foo"
    select "needs", from: "entry_needs"
    fill_in "entry_verb", with: "bar"
    click_on "This needs to happen"
    expect(page).to have_content("More foo needs to bar.")
    expect(find("#entry_noun").value).to be_empty
    fill_in "entry_noun", with: "pugs"
    select "need", from: "entry_needs"
    fill_in "entry_verb", with: "buzz"
    click_on "This needs to happen"
    expect(page).to have_content("More pugs need to buzz.")
  end
end

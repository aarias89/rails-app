require 'rails_helper'

RSpec.feature "Signing out signed in users" do
  before do
    @mike = User.create!(email: "mike@example.com", password: "likesbikes")

    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @mike.email
    fill_in "Password", with: @mike.password
    click_button "Log in"
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Sign out")
  end

end

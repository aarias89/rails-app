require 'rails_helper'

RSpec.feature "Users signin" do

  before do
    @mike = User.create!(email: "mike@example.com", password: "likesbikes")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @mike.email
    fill_in "Password", with: @mike.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@mike.email}")
    expect(page).not_to_have_link("Sign in")
    expect(page).not_to_have_link("Sign up")

  end

end
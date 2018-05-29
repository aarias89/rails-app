require 'rails_helper'

RSpec.feature "Creating Articles" do

  before do
    @mike = User.create!(email: "mike@example.com", password: "likesbikes")
    login_as(@mike)
  end

  scenario "User creates a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title",with: "Creating A Blog"
    fill_in "Body", with: "Lorem Ipsum"

    click_button "Create Article"

    expect(Article.last.user).to eq(@mike)
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by : #{@mike.email} ")
  end

  scenario "User fails to create article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Create Article"

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end

end
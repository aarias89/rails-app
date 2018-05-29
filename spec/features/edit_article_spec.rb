require 'rails_helper'

RSpec.feature "Editing an article" do

  before do
    Bilbo = User.create(email: "baggins@example.com", password: "password")
    login_as(Bilbo)
    @article =  Article.create(title: "Title of Article", body: "Body of Article", user: Bilbo)
  end

  scenario "An user updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body of Article"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "An user fails to updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated Body of Article"
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article))
  end
end
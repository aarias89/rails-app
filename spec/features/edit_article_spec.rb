require 'rails_helper'

RSpec.feature "Editing an article" do

  before do
    @article =  Article.create(title: "Title of Article", body: "Body of Article")
  end

  scenario "An user updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body of Article"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page).current_path.to eq(article_path(@article))
  end

  scenario "An user fails toupdates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated Body of Article"
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page).current_path.to eq(article_path(@article))
  end
end
require 'rails_helper'

RSpec.feature "Deleting an Article" do
  before do
    Bilbo = User.create(email: "baggins@example.com", password: "password")
    login_as(Bilbo)
    @article =  Article.create(title: "Title of Article", body: "Body of Article", user: Bilbo)
  end

  scenario "An user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end


end
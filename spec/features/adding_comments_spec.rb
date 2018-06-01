require 'rails_helper'

RSpec.feature "Adding reviews to articles" do
  before do
    @Bilbo = User.create(email: "baggins@example.com", password: "password")
    @Gandalf = User.create(email: "you@example.com", password: "ShallNotPass")
    @article =  Article.create!(title: "Title of Article", body: "Body of Article", user: @Bilbo)
  end

  scenario "permits a signed in user to write a review" do
    login_as(@Gandalf)

    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "An amazing Article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing Article")
    expect(current_path).to eq(article_path(@article.id))
  end

end
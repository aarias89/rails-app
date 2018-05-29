require 'rails_helper'

RSpec.feature "Showing an Article" do

  before do
    @Bilbo = User.create(email: "baggins@example.com", password: "password")
    @Gandalf = User.create(email: "You@example.com", password: "ShallNotPass")
    @article = Article.create(title: "First test article", body:" Lorem Ipsum", user: @Bilbo)
  end

  scenario "hide edit and delete to non signed in user" do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    # comparing 2 paths
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "hide edit and delete to non-owner" do
    login_as(@Gandalf)
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    # comparing 2 paths
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "signed in owner sees edit and delete button" do
    login_as(@Bilbo)
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    # comparing 2 paths
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

end
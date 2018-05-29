require 'rails_helper'

RSpec.feature "Listing Articles" do

  before do
    Bilbo = User.create(email: "baggins@example.com", password: "password")
    @article1 = Article.create(title: "First test article", body:" Lorem Ipsum", user: Bilbo)
    @article2 = Article.create(title: "Second test article", body: "Lorem Ipsum, I know no Latin", user: Bilbo)
  end

  scenario "with articles created and user not signed in" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)

    expect(page).not_to have_link("New Article")

  end

  scenario "A user has no artices" do
    Article.delete_all

    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)

    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)

    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within ("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end

  end



end
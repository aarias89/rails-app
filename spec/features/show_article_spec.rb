require 'rails_helper'

RSpec.feature "Showing an Article" do

  before do
    @article = Article.create(title: "First test article", body:" Lorem Ipsum")
  end

  scenario " A user shows an article" do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    # comparing 2 paths
    expect(current_path).to eq(article_path(@article))
  end


end
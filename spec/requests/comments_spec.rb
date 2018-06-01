require 'rails_helper'

RSpec.describe "Comments", type: :request do

  before do
    @Bilbo = User.create(email: "baggins@example.com", password: "password")
    @Gandalf = User.create(email: "you@example.com", password: "ShallNotPass")
    @article =  Article.create!(title: "Title of Article", body: "Body of Article", user: @Bilbo)
  end

  describe "POST /article/:id/comments" do
    context "with a non signed in user" do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "This is body"}}
      end

      it "redirects user to sign in page" do
        flash_message = "You need to be signed in to do that"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "with a logged in user" do
      before do
        login_as(@Gandalf)
        post "/articles/#{@article.id}/comments", params: {comment: {body: "This is body"}}
      end

      it "create the comment successfully" do
        flash_message = "Comment has been created"
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message
      end
    end
  end
end
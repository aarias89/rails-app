require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @Bilbo = User.create(email: "baggins@example.com", password: "password")
    @Gandalf = User.create(email: "you@example.com", password: "ShallNotPass")
    @article =  Article.create!(title: "Title of Article", body: "Body of Article", user: @Bilbo)
  end

  #Delete------------------

  describe 'DELETE/articles/:id' do

    context 'with non-signed in user' do
      before { delete "/articles/#{@article.id}" }

      it "redirects to signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@Gandalf)
        delete "/articles/#{@article.id}"
      end

      it "redirects to home page" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article"
        expect(flash[:danger]).to eq flash_message
      end
    end

    context 'with signed in user who is owner successful delete' do
      before do
        login_as @Bilbo
        delete "/articles/#{@article.id}"
      end

      it "succesfully deletes article" do
        expect(response.status).to eq 302
      end
    end

  end

# Edit/Update --------------

  describe 'GET/articles/:id' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it "redirects to signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@Gandalf)
        get "/articles/#{@article.id}/edit"
      end

      it "redirects to home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article"
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is owner successful edit' do
      before do
        login_as @Bilbo
        get "/articles/#{@article.id}/edit"
      end

      it "succesfully edits article" do
        expect(response.status).to eq 200
      end
    end

  end

# Retreive -------------------------

  describe 'GET/articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it "handles existing articles" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it "handles non-existing articles" do
        expect(response.status).to eq 302

        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end

end
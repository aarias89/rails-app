class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def create
    #create using strong params, this is a private method in order to whitelist info that it gets from the web.
    @article = Article.new(article_params)
    @article.save
    #If successful save
    flash[:success] = "Article has been created"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:article, :body)
  end


end

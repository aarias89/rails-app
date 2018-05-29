class ArticlesController < ApplicationController
  def index
    @articles =  Article.all
  end

  def new
    @article = Article.new
  end

  def create
    #create using strong params, this is a private method in order to whitelist info that it gets from the web.
    @article = Article.new(article_params)
     if @article.save #If successful save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end

  def show
    @article =  Article.find(params[:id])
  end

  protected

  def resource_not_found
    message = "The article you are looking for could not be found"
    flash[:alert] = message
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end


end

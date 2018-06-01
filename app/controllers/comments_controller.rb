class CommentsController < ApplicationController
  before_action :set_article

  def create
    # use strong params (comment_params)
    @comment =  @article.comments.build(comment_params)
    @comment.user = current_user
      if @comment.save
        flash[:notice] = "Comment has been created"
      else
        flash.now[:alert] = "Failed to create commment"
      end
      redirect_to article_path(@article)
  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

end

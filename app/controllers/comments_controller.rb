class CommentsController < ApplicationController
  before_action :set_article

  def create
    unless current_user
      flash[:alert] = "You need to be signed in to do that"
      redirect_to new_user_session_path
    else
      # use strong params (comment_params)
      @comment =  @article.comments.build(comment_params)
      @comment.user = current_user
      # this is where the comments interact with our DB, this is where we setup ActionCable
        if @comment.save
          ActionCable.server.broadcast "comments",
            render(partial: 'comments/comment', object: @comment )
          flash[:notice] = "Comment has been created"
        else
          flash.now[:alert] = "Failed to create commment"
        end
        # redirect_to article_path(@article)
      end
  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

end

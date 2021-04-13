class CommentsController < ApplicationController
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment has been created"
    else
      flash.now[:alert] = "Comment has NOT been created"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:id, :body)
    end

    def set_article
      @article = Article.find(params[:artilce_id])
    end
end
class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to @comment.playlist
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :playlist_id, :content)
  end
end

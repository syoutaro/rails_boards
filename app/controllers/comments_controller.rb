class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to @comment.board
    else
      flash[:alert] = @comment.errors.full_messages
      redirect_back fallback_location: @comment.board
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    flash[:notice] = "コメントを削除しました"
    redirect_to @comment.board
  end

  protected

  def comment_params
    params.require(:comment).permit(:comment, :board_id)
  end
end

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to board_path(params[:board_id]), success: 'コメントを作成しました'
    else
      redirect_to board_path(@comment.board), danger: 'コメントを作成できませんでした'
    end
  end

  def edit; end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end

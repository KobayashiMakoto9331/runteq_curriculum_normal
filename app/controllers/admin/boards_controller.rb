class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[edit destroy update show]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def show; end

  def update
    if @board.update(board_params)
      redirect_to admin_board_path(@board), success: '掲示板を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to admin_boards_path, success: '掲示板を削除しました'
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end

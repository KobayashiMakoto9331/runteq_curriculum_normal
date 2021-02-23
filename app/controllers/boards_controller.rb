class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[new]

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to boards_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end
end

private

def board_params
  params.require(:board).permit(:title, :body)
end
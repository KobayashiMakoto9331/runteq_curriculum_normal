class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    redirect_back fallback_location: root_path, success: 'ブックマークしました'
  end

  def destroy
    # board = current_user.bookmarks.find_by(params[:id]).board
    board = Board.find(params[:board_id])
    current_user.unbookmark(board)
    redirect_back fallback_location: root_path, success: 'ブックマークを外しました'
  end
end

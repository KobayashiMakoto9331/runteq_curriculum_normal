class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[new create ]

  def new
  end

  def index
    @boards=Board.all.includes(:user)
  end


end

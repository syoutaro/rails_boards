class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.new
  end

  def create
    @board = current_user.boards.create(board_params)
    if @board.save
      flash[:notice] = "投稿しました。"
      redirect_to :root
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  protected

  def board_params
    params.require(:board).permit(:title, :body)
  end
end

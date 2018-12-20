class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @boards = get_boards
    @boards = @boards.page(params[:page]).per(6).order('updated_at DESC')
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
      flash[:alert] = @board.errors.full_messages
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      flash[:notice] = "編集しました。"
      redirect_to edit_board_path
    else
      flash[:alert] = @board.errors.full_messages
      render :edit
    end
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    flash[:notice] = "削除しました。"
    redirect_to :root
  end

  protected

  def board_params
    params.require(:board).permit(:title, :body, tag_ids: [])
  end

  def get_boards
    params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
  end
end
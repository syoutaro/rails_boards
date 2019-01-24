class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    respond_to do |format|
      format.html do
        @boards = get_boards
        @boards = @boards.page(params[:page]).per(6).order('updated_at DESC')
      end
      format.csv do
        @boards = current_user.boards
        send_data render_to_string, filename: "current_user_boards.csv", type: :csv
      end
    end
  end

  def new
    @board = current_user.boards.new
  end

  def create
    Board.transaction do
      @board = current_user.boards.create!(board_params)
      current_user.lose_point!
    end
    flash[:notice] = "投稿しました。"
    redirect_to :root
  rescue => e
    flash[:alert] = @board.errors.full_messages
    render :new
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

  private

  def board_params
    params.require(:board).permit(:title, :body, :image, tag_ids: [])
  end

  def get_boards
    params[:tag_id].present? ? Tag.find(params[:tag_id]).boards.includes(:owner) : Board.includes(:owner).all
  end
end

class TagsController < ApplicationController

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "タグを作成しました"
      redirect_to :root
    else
      flash[:alert] = @tag.errors.full_messages
      render :new
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end

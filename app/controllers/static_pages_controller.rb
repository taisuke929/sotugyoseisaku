class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def top
    @boards = if params[:tag_id].present?
                Tag.find(params[:tag_id]).boards.order(created_at: :desc)
              else
                Board.all.order(created_at: :desc)
              end

    @boards = @boards.page(params[:page]).per(10)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      @board.tags = Tag.where(id: params[:board][:tag_ids])
      redirect_to root_path, notice: '掲示板が作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end
  
  def edit
    @board = current_user.boards.find(params[:id])
    @tags = @board.tags 
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      @board.tags = Tag.where(id: params[:board][:tag_ids])
      redirect_to  root_path, notice: '掲示板が更新されました'
    else
      render :edit, status: :unprocessable_entity, alert: '掲示板を更新できませんでした。入力内容を確認してください。'
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: '掲示板が削除されました', status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :rank, :lane, :purpose, tag_ids: [])
  end

  def authenticate_user!
    unless logged_in?
      redirect_to new_session_path,  alert:"ログインしてください。"
    end
  end
end

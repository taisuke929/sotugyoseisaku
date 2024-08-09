class CommentsController < ApplicationController
  before_action :set_board
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @board.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to static_page_path(@board), notice: 'コメントが投稿されました'
    else
      @comments = @board.comments.includes(:user).order(created_at: :desc)
      render 'static_pages/show', alert: 'コメントを投稿できませんでした。入力内容を確認してください。'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to static_page_path(@board), notice: 'コメントが更新されました'
    else
      render :edit, alert: 'コメントを更新できませんでした。入力内容を確認してください。'
    end
  end

  def destroy
    @comment.destroy
    redirect_to static_page_path(@board) , notice: 'コメントが削除されました'
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_comment
    @comment = @board.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: 'ユーザー登録が完了しました'
    else
      render :new, alert: '登録に失敗しました。入力内容を確認してください。'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールが更新されました'
    else
      render :edit, alert: '更新に失敗しました。入力内容を確認してください。'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :rank, :lane)
  end
end
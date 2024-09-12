class PasswordResetsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to new_session_path, success: "パスワードリセットのメールを送信しました。"
    else
      flash.now[:danger] = "メールアドレスが見つかりませんでした。"
      render :new
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to new_session_path, success: "パスワードを変更できました"
    else
      flash.now[:danger] = "パスワード変更出来ませんでした"
      render :edit
    end
  end

end

class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが無効です'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'ログアウトしました'
  end
end

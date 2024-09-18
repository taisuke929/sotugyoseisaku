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

  def google_oauth2
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Googleでログインしました'
    else
      redirect_to new_session_path, alert: 'Googleログインに失敗しました'
    end
  end
end

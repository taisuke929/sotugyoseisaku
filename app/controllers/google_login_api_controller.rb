class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'

  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token

  def callback
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '951682237838-h59na5sbpq34t855mfbbr3qh07dqgl2n.apps.googleusercontent.com')
    
    # Userをemailで検索し、存在しなければ新しいユーザーを作成
    user = User.find_or_create_by(email: payload['email']) do |new_user|
      new_user.name = payload['name'] # Googleから取得した名前をセット
    end
    
    # デバッグ: ユーザーが正しく作成されたか確認
    if user.persisted?
      # ユーザーが保存されている場合のみセッションにIDを保存
      session[:user_id] = user.id
      flash[:notice] = 'ログインしました'
    else
      # ユーザーが保存されていない場合はエラーメッセージを表示
      flash[:alert] = 'ログインに失敗しました'
    end
    
    redirect_to root_path
  end
  

  private

  def verify_g_csrf_token
    if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
      redirect_to root_path, notice: '不正なアクセスです'
    end
  end
end
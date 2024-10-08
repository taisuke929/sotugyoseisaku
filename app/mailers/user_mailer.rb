class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def reset_password_email(user)
    @user = User.find(user.id)
    @url = edit_password_reset_url(@user.reset_password_token, host: 'localhost', port: 3002)
    mail(to: user.email,subject: "パスワードリセット")
  end

end

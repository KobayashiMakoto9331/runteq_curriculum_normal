class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def change_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_change_url(@user.reset_password_token)
    mail(to: @user.email, subject: 'パスワードリセット')
  end
end

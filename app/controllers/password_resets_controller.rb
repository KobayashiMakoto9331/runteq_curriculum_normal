class PasswordResetsController < ApplicationController
  skip_before_action :require_login
 
  def new; end
 
  def create
    @user = User.find_by(email: params[:email])
    # DBにデータがあればreset_password_emailメソッド発動。(メールは有効期限付き)
    @user&.deliver_reset_password_instructions!
    #「存在しないメールアドレスです」という旨の文言を表示すると、逆に存在する
    # メールアドレスを特定されてしまうため、DB内にデータがあるかないかに関わらず
    # 成功時のメッセージを送信。
    redirect_to login_path, success: 'パスワードリセット手順を送信しました'
  end
 
  def edit
    @token = params[:id]
    # リクエストで送信されてきたトークンにマッチするデータがあり
    # 有効期限内であれば@userにデータを代入。
    @user = User.load_from_reset_password_token(@token)
    #@userがnilかblankであればnot_authenticatedメソッドを返す。
    not_authenticated if @user.blank?
  end
 
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
 
    return not_authenticated if @user.blank?
 
    @user.password_confirmation = params[:user]
                                        [:password_confirmation]
    #トークンを削除してパスワードを更新。
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: 'パスワードを変更しました'
    else
      flash.now[:danger] = 'パスワードを変更できませんでした'
      render :edit
    end
  end
end

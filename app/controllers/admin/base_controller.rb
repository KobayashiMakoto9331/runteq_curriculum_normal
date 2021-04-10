class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'
  skip_before_action :require_login
  
  private

  def not_authenticated
    flash[:worning] = 'ログインしてください'
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, warning: '権限がありません' unless current_user.admin?
  end

end

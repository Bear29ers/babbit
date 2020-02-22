class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        @user.update_attribute(:login_at, Time.zone.now)
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        flash[:success] = "ログインしました"
        redirect_back_or @user
      else
        flash[:warning] = "アカウントが有効化されていません 送信されたメール内容をご確認ください"
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが正しくありません'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
end

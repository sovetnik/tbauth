class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if @user = login(params[:email], params[:password])
      @user.set_token!
      redirect_back_or_to(grants_welcome_path, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    current_user.forget_token!
    @current_user = nil
    reset_session
    redirect_to(:users, notice: 'Logged out!')
  end
end

class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to grants_welcome_path, :notice => "Logged in from #{provider.titleize}!"
    else
      callback_login(provider)
    end
  end

  private

  def callback_login(provider)
    @user = create_from(provider)
    reset_sorcery_session
    auto_login(@user)
    redirect_back_or_to grants_welcome_path, :notice => "Logged in from #{provider.titleize}!"
  rescue
    redirect_to login_path, :alert => "Failed to login from #{provider.titleize}!"
  end
end

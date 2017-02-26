class GrantsController < ApplicationController
  skip_before_action :require_login, only: [:token]

  def token
    session[:target_url] = request.referrer # if we not yet logged on auth,
    session[:public_key] = params[:key]
    if logged_in?
      redirect_to callback_url
    else
      redirect_to login_path
    end
  end

  def welcome
    if session[:target_url] && session[:public_key]
      redirect_to callback_url 
    else
      redirect_to profile_path
    end
  end

  private

  def callback_url
    "#{session[:target_url]}?token=#{base_encrypted_token}"
  end

  def base_encrypted_token
    Base64.urlsafe_encode64(rsa_encrypted_token)
  end

  def rsa_encrypted_token
    rsa.public_encrypt(current_user.get_token)
  end

  def rsa
    @rsa ||= OpenSSL::PKey::RSA.new(decoded_public_key)
  end

  def decoded_public_key
    Base64.urlsafe_decode64(session[:public_key])
  end
end

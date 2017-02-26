class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def not_authenticated
    redirect_to login_path
  end

  protected

  def reset_sorcery_session
    old_session = session.dup.to_hash
    reset_session
    old_session.each_pair do |k, v|
      session[k.to_sym] = v
    end
  end
end

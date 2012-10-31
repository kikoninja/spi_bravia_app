class ApplicationController < ActionController::Base
  include InvideousAuth
  protect_from_forgery

  # Filters
  before_filter :set_locale
  # before_filter :authenticate_user!
  # Invideous Auth
  helper_method :current_user

  def current_admin_user
    @current_admin_user ||= User.find(session[:admin_user_id]) if session[:admin_user_id]
  end

  private

  # FIXME: PD: Horrible workaround! 
  def authenticate_admin_user!
    redirect_to new_admin_session_path unless current_admin_user && current_admin_user.is_admin?
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(option = {})
    {locale: I18n.locale}
  end
end

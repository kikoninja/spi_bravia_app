class ApplicationController < ActionController::Base
  include InvideousAuth
  protect_from_forgery

  # Filters
  # before_filter :authenticate_user!
  # Invideous Auth
  before_filter :check_if_invideous_session_attached

  private

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user && current_user.is_admin?
  end
end

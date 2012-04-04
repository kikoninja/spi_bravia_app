class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.is_admin?
  end
end

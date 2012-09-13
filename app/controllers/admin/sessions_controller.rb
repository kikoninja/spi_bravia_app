class Admin::SessionsController < ApplicationController
  # layout 'sign'

  def new
  end

  def create
    user = User.find_by_email(params[:admin_session][:email])
    if user && user.authenticate(params[:admin_session][:password])
      session[:admin_user_id] = user.id
      redirect_to admin_root_url, :notice => 'Logged in successfully.'
    else
      flash.now[:error] = 'Invalid email or password.'
      render 'new'
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to root_url
  end

  def show

  end

end

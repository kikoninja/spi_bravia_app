class SessionsController < ApplicationController

  def new
  end

  def create
    username = params[:session][:username]
    password = params[:session][:password]

    @invideous = Invideous.new(cookies, request)
    resp = @invideous.login(username, password)

    logger.info("Result: #{resp}")

    if resp["response"]["status"] == "error"
      flash[:error] = resp["response"]["message"]
      redirect_to root_path
    else
      flash.now[:notice] = "Logged in successfully"
      session[:user] = resp["response"]["result"]["user_info"] 
      cookies[:session_id] = session[:user][:session_id]
      redirect_to connect_success_path
    end
  end

  def destroy
    session[:user] = nil

    inv = Invideous.new(cookies)
    inv.logout
    flash[:notice] = "Succesfully logged out"

    redirect_to root_path
  end

end

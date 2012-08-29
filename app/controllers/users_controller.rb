class UsersController < ApplicationController

  respond_to :js

  def new
  end

  def create
    fullname = params[:users][:full_name]
    password = params[:users][:password]
    password_confirm = params[:users][:password_confirm]
    email = params[:users][:email]

    inv = Invideous.new(cookies)
    @result = inv.register(email, password, password_confirm, fullname)

    logger.info("Password: #{password}")
    logger.info("Registration result: #{@result}")

    @result = @result["response"]

    if @result["status"] == "error"
      flash[:error] = @result["message"]
      redirect_to root_path
    else
      flash.now[:notice] = @result["message"]
      inv.login(@result["result"]["user_info"]["username"], password)
      session[:user] = @result["result"]["user_info"] 
      redirect_to connect_success_path
    end
  end

end

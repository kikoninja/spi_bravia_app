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

      # Check if the user is already registered
      user = AffiliatedUser.where(username: session[:user]).first

      if user
        # Do something
      else
        # Generate SUIT
        uuid = UUID.new
        suit = Digest::MD5.hexdigest(uuid.generate)

        # Create the user in the database
        AffiliatedUser.create!(username: session[:user], suit: suit)

        # Call the sony authnentication server to send the info that user has been affiliated
        url = "#{session[:done]}/SSMPutToken?version=#{session[:version]}&provider=FilmBoxLive_Prod&sid=#{session[:sid]}&sig=#{session[:sig]}&suit=#{suit}"
        uri = URI.parse(url)
        result = Net::HTTP.get_request(uri)
        Logger.info("Result: #{result}")
      end

      redirect_to connect_success_path
    end
  end

  def destroy
    session[:user] = nil

    inv = Invideous.new(cookies)
    inv.logout
    inv.cleanup_cookies
    flash[:notice] = "Succesfully logged out"

    redirect_to root_path
  end

end

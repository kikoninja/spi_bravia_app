class AuthorizationController < ApplicationController

  respond_to :xml

  def sts_get_authorization
    @asset_id = params[:id]

    user = AffiliatedUser.find_by_suit(params[:suit])

    if user.nil?
      @result = "fail"
      @result_code = -2027
    else
      @result = "success"
      @result_code = 0
    end

    render content_type: 'application/xml'
  end

  def ssm_get_userdata
    # Fill the session parameters
    # {"version"=>"0", "sid"=>"OJSWG7CP204A1JXU", "grant_timestamp"=>"2012-08-20T14:43:30Z", "expiration_timestamp"=>"2037-12-31T19:59:59Z", "lang"=>"en", "country"=>"USA", "done"=>"http://b2b-dev.internet.sony.tv/serviceAssociation", "sig"=>"5B0D4E0DE86086D6A0CD461E1E39C6F4"}
    session[:version] = params[:version]
    session[:sid] = params[:sid]
    session[:grant_timestamp] = params[:grant_timestamp]
    session[:expiration_timestamp] = params[:lang]
    session[:country] = params[:country]
    session[:done] = params[:done]
    session[:sig] = params[:sig]

    redirect_to APP_SETTINGS[Rails.env]['affiliation_url']
  end

  def disconnect
    user = AffiliatedUser.find_by_suit(params[:suit])

    if user
      user.delete
    end

    render :text => "ok"
  end

end

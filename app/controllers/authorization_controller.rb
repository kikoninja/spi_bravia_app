class AuthorizationController < ApplicationController
  include ApplicationHelper

  respond_to :xml

  # Error codes
  SUCCESS = 0
  ERROR_UNKNOWN_REQUEST = 40
  ERROR_SIG_INVALID = -2002
  ERROR_AUTH_UNKNOWN = -2027
  ERROR_REQUEST_TS_INVALID = -2030

  def sts_get_authorization
    @asset_id = params[:id]

    signature = calculate_signature(params)

    # TODO: PD: The signature can be calculated inside the authorizer, make this first thing next time when you refactor this code
    authorizer = Authorizer.new(signature, params) 
    authorizer.authorize
    
    if authorizer.error_code == Authorizer::SUCCESS
      user = AffiliatedUser.find_by_suit(params[:suit])
      if user
        @result = "success"
        @result_code = Authorizer::SUCCESS
      else
        @result = "fail"
        @result_code = Authorizer::ERROR_AUTH_UNKNOWN
      end
    else
      @result = "fail"
      @result_code = authorizer.error_code
    end

    render content_type: 'application/xml'
  end

  def ssm_get_userdata
    # Fill the session parameters
    # {"version"=>"0", "sid"=>"OJSWG7CP204A1JXU", "grant_timestamp"=>"2012-08-20T14:43:30Z", "expiration_timestamp"=>"2037-12-31T19:59:59Z", "lang"=>"en", "country"=>"USA", "done"=>"http://b2b-dev.internet.sony.tv/serviceAssociation", "sig"=>"5B0D4E0DE86086D6A0CD461E1E39C6F4"}
    session[:version] = params[:version]
    session[:sid] = params[:sid]
    session[:grant_timestamp] = params[:grant_timestamp]
    session[:expiration_timestamp] = params[:expiration_timestamp]
    session[:lang] = params[:lang]
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

  private

  def check_date_if_valid(date)
    begin
      Date.parse(date)
    rescue
      false
    end
  end

  def check_if_signature_valid(sig)
    sig == session[:sig]
  end

end

class AuthorizationController < ApplicationController

  respond_to :xml

  def sts_get_authorization
    @reg_url = Rails.env == "development" ? "http://dev.internet.sony.tv" : "http://internet.sony.tv"
    @asset_id = params[:id]

    render content_type: 'application/xml'
  end

  def ssm_get_userdata
    render content_type: 'application/xml'
  end

end

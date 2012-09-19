class AuthorizationController < ApplicationController

  respond_to :xml

  def sts_get_authorization
    @asset_id = params[:id]

    render content_type: 'application/xml'
  end

  def ssm_get_userdata
    # render content_type: 'application/xml'
    redirect_to APP_SETTINGS[Rails.env]['affiliation_url']
  end

end

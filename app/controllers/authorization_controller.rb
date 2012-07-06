class AuthorizationController < ApplicationController

  def sts_get_authorization
    render text => "ok"
  end

end

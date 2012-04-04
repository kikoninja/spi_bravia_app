class FeedsController < ApplicationController

  respond_to :xml

  def branch
    @channel = Channel.first

    render :content_type => 'application/xml'
  end

end

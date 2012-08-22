class FeedsController < ApplicationController

  respond_to :xml

  # Filters
  before_filter :load_channel

  def show
    @reg_url = Rails.env == "development" ? "http://dev.internet.sony.tv" : "http://internet.sony.tv"
    @feed = Feed.find_by_title(params[:id])

    render :content_type => 'application/xml'
  end

  private

  def load_channel
    @channel = Channel.first
  end

end

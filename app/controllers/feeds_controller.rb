class FeedsController < ApplicationController

  respond_to :xml

  # Filters
  before_filter :load_channel

  def show
    @feed = Feed.find_by_title(params[:id])

    render :content_type => 'application/xml'
  end

  private

  def load_channel
    @channel = Channel.first
  end

end

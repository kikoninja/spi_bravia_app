class Asset < ActiveRecord::Base

  # Associations
  belongs_to :feed
  belongs_to :video

  attr_accessible :feed, :feed_id, :asset_type, :content_id, :description, :duration, :pay_content, :title
end

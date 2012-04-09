class Asset < ActiveRecord::Base

  # Associations
  belongs_to :feed
  belongs_to :video
  has_many :asset_categorizations
  has_many :categories, :through => :asset_categorizations

  attr_accessible :feed, :feed_id, :asset_type, :content_id, :description, :duration, :pay_content, :title, :video_id, :categories
end

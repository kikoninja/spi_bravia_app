class Feed < ActiveRecord::Base

  # Associations
  has_many :assets
  belongs_to :channel

  attr_accessible :title, :channel, :channel_id, :assets
end

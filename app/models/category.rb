class Category < ActiveRecord::Base

  # Associations
  belongs_to :channel
  has_many :asset_categorizations
  has_many :assets, :through => :asset_categorizations

  # Uploaders
  mount_uploader :icon, IconUploader

  # Acessibles
  attr_accessible :title, :description, :style, :order, :channel, :channel_id, :icon, :assets
end

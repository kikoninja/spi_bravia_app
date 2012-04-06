class Category < ActiveRecord::Base

  # Associations
  belongs_to :channel

  # Uploaders
  mount_uploader :icon, IconUploader

  # Acessibles
  attr_accessible :title, :description, :style, :order, :channel, :channel_id, :icon
end

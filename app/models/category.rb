class Category < ActiveRecord::Base

  has_ancestry

  # Associations
  belongs_to :channel
  has_and_belongs_to_many :assets, :join_table => :asset_categorizations

  # Uploaders
  mount_uploader :icon, IconUploader

  # Acessibles
  attr_accessible :title, :description, :style, :order, :channel, :channel_id, :icon, :assets, :ancestry, :parent_id
end

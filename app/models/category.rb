class Category < ActiveRecord::Base

  has_ancestry

  STYLES = [ "tile", "row"]

  # Associations
  belongs_to :channel
  has_and_belongs_to_many :assets, :join_table => :asset_categorizations, :uniq => true

  # Uploaders
  mount_uploader :icon, IconUploader

  # Acessibles
  attr_accessible :title, :description, :style, :order, :channel, :channel_id, :icon, :remote_icon_url, :assets, :ancestry, :parent_id, :parent, :region_ref
end

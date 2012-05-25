class Package < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  PUBLISHER_ID = 5842 # Hardcoded for SPI

  # Associations
  has_many :packages_videos
  has_many :videos, :through => :packages_videos

  # Scopes
  default_scope where(:publisher_id => PUBLISHER_ID)

end

class Package < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  #PUBLISHER_ID = 5842 # Hardcoded for SPI

  # Attributes
  attr_accessor :image_url

  # Associations
  has_many :packages_videos
  has_many :videos, :through => :packages_videos
  belongs_to :publisher

  # Scopes
  #default_scope where(:publisher_id => PUBLISHER_ID)

  # Ugly fix for the missing images
  def image_url
    File.open("#{Rails.root}/public/images/icons/#{external_id}.png")
  rescue
    puts "Warning: Icon not found for package: #{name}"
    return ""
  end

end

class Package < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  PUBLISHER_ID = 5842 # Hardcoded for SPI

  # Attributes
  attr_accessor :image_url

  # Associations
  has_many :packages_videos
  has_many :videos, :through => :packages_videos

  # Scopes
  default_scope where(:publisher_id => PUBLISHER_ID)

  # Ugly fix for the missing images
  def image_url
    case external_id
    when "DocuBox"
      return "http://w4.invideous.com/demo/Invideous_for_SPI_Sony_ServiceDefinition_11.03.2012/icons_sony/86x36/docubox_86x36.png"
    when "PolishPackage"
      return "http://w4.invideous.com/demo/Invideous_for_SPI_Sony_ServiceDefinition_11.03.2012/icons_sony/86x36/kinopolska_86x36.png"
    when "FilmPackage"
      return "http://w4.invideous.com/demo/Invideous_for_SPI_Sony_ServiceDefinition_11.03.2012/icons_sony/86x36/filmboxlive_86x36.png"
    when "FashionBox"
      return "http://w4.invideous.com/demo/Invideous_for_SPI_Sony_ServiceDefinition_11.03.2012/icons_sony/86x36/fashionbox_86x36.png"
    when "FightBox"
      return "http://w4.invideous.com/demo/Invideous_for_SPI_Sony_ServiceDefinition_11.03.2012/icons_sony/86x36/fightbox_86x36.png"
    when "UltimatePackage"
      return "http://w4.invideous.com/demo/Invideous_for_SPI_Sony_ServiceDefinition_11.03.2012/icons_sony/86x36/filmboxpremiere_86x36.png"
    end
  end

end

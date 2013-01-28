class Publisher < ActiveRecord::Base
  has_many :packages
  has_many :packages_videos, :through => :packages 

  attr_accessible :publisher_id, :country_code, :region_id
end